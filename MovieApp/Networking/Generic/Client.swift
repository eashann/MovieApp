//
//  Client.swift
//  MovieApp
//
//  Created by Eashan on 14/9/22.
//

import Foundation
import Combine

protocol CombineAPI {
    var session: URLSession { get }
    func execute<T>(_ request: URLRequest,
                    decodingType: T.Type,
                    queue: DispatchQueue,
                    retries: Int) -> AnyPublisher<T, Error> where T: Decodable
    func performNetworkRequest<T: Decodable>(_ request: URLRequest, decodingType: T.Type, retries: Int) -> Future<T, Error>
}

extension CombineAPI {
    
    func execute<T>(_ request: URLRequest,
                    decodingType: T.Type,
                    queue: DispatchQueue = .main,
                    retries: Int = 0) -> AnyPublisher<T, Error> where T: Decodable {
        
        return session.dataTaskPublisher(for: request)
            .tryMap {
                guard let response = $0.response as? HTTPURLResponse, response.statusCode == 200 else {
                    throw NetworkError.requestFailed
                }
                return $0.data
            }
            .decode(type: T.self, decoder: JSONDecoder())
            .receive(on: queue)
            .retry(retries)
            .eraseToAnyPublisher()
    }
    
    func performNetworkRequest<T: Decodable>(_ request: URLRequest, decodingType: T.Type, retries: Int) -> Future<T, Error> {
        Future { promise in
            var cancellables = Set<AnyCancellable>()
            session.dataTaskPublisher(for: request)
                .tryMap {
                    guard let httpResponse = $0.response as? HTTPURLResponse, 200...299 ~= httpResponse.statusCode else {
                        throw NetworkError.requestFailed
                    }
                    return $0.data
                }
                .decode(type: T.self, decoder: JSONDecoder())
                .receive(on: RunLoop.main)
                .retry(retries)
                .sink { completion in
                    if case let .failure(error) = completion {
                        switch error {
                        case let decodingError as DecodingError:
                            promise(.failure(decodingError))
                        case let apiError as NetworkError:
                            promise(.failure(apiError))
                        default:
                            promise(.failure(NetworkError.unknown))
                        }
                    }
                } receiveValue: { promise(.success($0)) }
                .store(in: &cancellables)
        }
    }
}
