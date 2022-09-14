//
//  SearchClient.swift
//  MovieApp
//
//  Created by Eashan on 14/9/22.
//

import Foundation
import Combine

final class SearchClient: CombineAPI {
    
    let session: URLSession
    
    init(configuration: URLSessionConfiguration) {
        self.session = URLSession(configuration: configuration)
    }
    
    convenience init() {
        self.init(configuration: .default)
    }
    
    func searchMovie(_ searchKind: SearchMovie) -> AnyPublisher<MovieFeedResult, Error> {
        execute(searchKind.searchRequest, decodingType: MovieFeedResult.self, retries: 2)
    }
}
