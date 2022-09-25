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
    var themoviedb_apiKey: String {
        if let path = Bundle.main.path(forResource: "Secrets", ofType: "plist"),
           let dict = NSDictionary(contentsOfFile: path),
           let key = dict["themoviedb_api_key"] as? String {
            return key
        }
        return ""
    }
    
    var themoviedb_base_url: String {
        if let path = Bundle.main.path(forResource: "Secrets", ofType: "plist"),
           let dict = NSDictionary(contentsOfFile: path),
           let key = dict["themoviedb_api_base_url"] as? String {
            return key
        }
        return ""
    }
    
    var themoviedb_image_base_url: String {
        if let path = Bundle.main.path(forResource: "Secrets", ofType: "plist"),
           let dict = NSDictionary(contentsOfFile: path),
           let key = dict["themoviedb_image_base_url"] as? String {
            return key
        }
        return ""
    }
}
