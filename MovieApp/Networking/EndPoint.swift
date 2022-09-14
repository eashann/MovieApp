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
        if let path = Bundle.main.path(forResource: "Secrets", ofType: "plist"),
           let dict = NSDictionary(contentsOfFile: path),
           let key = dict["APIKey"] as? String {
            return "api_key=\(key)"
        }
        return ""
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
