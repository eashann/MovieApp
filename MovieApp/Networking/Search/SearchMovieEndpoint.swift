//
//  SearchMovieEndpoint.swift
//  MovieApp
//
//  Created by Eashan on 14/9/22.
//

import Foundation

extension Endpoint {
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
