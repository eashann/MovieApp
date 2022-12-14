//
//  MovieClient.swift
//  MovieApp
//
//  Created by Eashan on 13/9/22.
//

import Foundation
import Combine

final class MovieClient: CombineAPI {
    
    let session: URLSession
    
    init(configuration: URLSessionConfiguration) {
        self.session = URLSession(configuration: configuration)
    }
    
    convenience init() {
        self.init(configuration: .default)
    }
    
    func getFeed(_ feedKind: MovieFeed) -> AnyPublisher<MovieFeedResult, Error> {
        execute(feedKind.movieFeedComponenet(), decodingType: MovieFeedResult.self, retries: 2)
    }
    
    func getMovieFeed(_ feedKind: MovieFeed) -> Future<MovieFeedResult, Error> {
        performNetworkRequest(feedKind.movieFeedComponenet(), decodingType: MovieFeedResult.self, retries: 1)
    }
}
