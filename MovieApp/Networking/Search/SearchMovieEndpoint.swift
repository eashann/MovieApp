//
//  SearchMovieEndpoint.swift
//  MovieApp
//
//  Created by Eashan on 14/9/22.
//

import Foundation

enum SearchMovie {
    case generic
}

extension SearchMovie: Endpoint {
    
    var base: String {
        return themoviedb_base_url
    }
    
    var path: String {
        switch self {
            case .generic: return "/3/search/movie"
        }
    }
}

extension SearchMovie {
    func searchRequestUsingComponenet(with query: String) -> URLRequest {
        var components = URLComponents(string: base)!
        components.path = path
        components.queryItems = [
            .init(name: "api_key", value: themoviedb_apiKey),
            .init(name: "query", value: "\(query)")]
        let url = components.url!
        return URLRequest(url: url)
    }
}
