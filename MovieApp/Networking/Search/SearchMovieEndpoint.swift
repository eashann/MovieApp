//
//  SearchMovieEndpoint.swift
//  MovieApp
//
//  Created by Eashan on 14/9/22.
//

import Foundation

extension Endpoint {
    
    var searchURLComponents: URLComponents {
        var components = URLComponents(string: base)!
        components.path = path
        components.queryItems = [
            .init(name: "api_key", value: themoviedb_apiKey),
            .init(name: "query", value: "marvel")]
        return components
    }
    
    var searchRequest: URLRequest {
        let url = searchURLComponents.url!
        return URLRequest(url: url)
    }
}
