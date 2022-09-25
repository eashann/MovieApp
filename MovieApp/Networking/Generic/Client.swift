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
//    func perform<T: Decodable>(_ request: URLRequest, decodingType: T.Type, retries: Int) -> Future<[T], Error>
}

extension CombineAPI {
    
    func execute<T>(_ request: URLRequest,
                    decodingType: T.Type,
                    queue: DispatchQueue = .main,
                    retries: Int = 0) -> AnyPublisher<T, Error> where T: Decodable {
        
        return session.dataTaskPublisher(for: request)
            .tryMap {
                guard let response = $0.response as? HTTPURLResponse, response.statusCode == 200 else {
                    throw APIError.responseUnsuccessful
                }
                return $0.data
            }
            .decode(type: T.self, decoder: JSONDecoder())
            .receive(on: queue)
            .retry(retries)
            .eraseToAnyPublisher()
    }
    
//    func perform<T: Decodable>(_ request: URLRequest, decodingType: T.Type, retries: Int) -> Future<[T], Error> {
//        Future { promise in
//            session.dataTaskPublisher(for: request)
//                .tryMap { (data, response) -> Data in
//                    guard let httpResponse = response as? HTTPURLResponse, 200...299 ~= httpResponse.statusCode else {
//                        throw APIError.responseUnsuccessful
//                    }
//                    return data
//                }
//                .decode(type: [T].self, decoder: JSONDecoder())
//                .receive(on: RunLoop.main)
//                .sink { errorCompletion in
//                    switch errorCompletion {
//                    case .finished:
//                        <#code#>
//                    case .failure(_):
//                        <#code#>
//                    }
//                } receiveValue: { promise(.success($0))}
//
//        }
//    }
}
