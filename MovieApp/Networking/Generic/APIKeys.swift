//
//  APIKeys.swift
//  MovieApp
//
//  Created by Eashan on 14/9/22.
//

import Foundation

extension Endpoint {
    var themoviedb_apiKey: String {
        if let path = Bundle.main.path(forResource: "Secrets", ofType: "plist"),
           let dict = NSDictionary(contentsOfFile: path),
           let key = dict["APIKey"] as? String {
            return key
        }
        return ""
    }
}
