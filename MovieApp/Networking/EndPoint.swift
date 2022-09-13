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
    var apiKey: String {
        return "api_key=4f0b4d47f39a9bc48fbe25d612f92919"
    }
    
    var urlComponents: URLComponents {
        var components = URLComponents(string: base)!
        components.path = path
        components.query = apiKey
        return components
    }
    
    var request: URLRequest {
        let url = urlComponents.url!
        return URLRequest(url: url)
    }
}
