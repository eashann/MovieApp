//
//  EndPoint.swift
//  MovieApp
//
//  Created by Eashan on 13/9/22.
//

import Foundation

protocol Endpoint {
    
    var base: String { get }
    var path: String { get }
}

extension Endpoint {
    
    var urlComponents: URLComponents {
        var components = URLComponents(string: base)!
        components.path = path
        components.queryItems = [
            .init(name: "api_key", value: themoviedb_apiKey)]
        return components
    }
    
    var request: URLRequest {
        let url = urlComponents.url!
        return URLRequest(url: url)
    }
}
