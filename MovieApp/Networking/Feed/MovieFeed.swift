//
//  MovieFeed.swift
//  MovieApp
//
//  Created by Eashan on 13/9/22.
//

import Foundation

enum MovieFeed {
    case nowPlaying
    case topRated
}
extension MovieFeed: Endpoint {
    
    var base: String {
        return "https://api.themoviedb.org"
    }
    
    var path: String {
        switch self {
        case .nowPlaying: return "/3/movie/now_playing"
        case .topRated: return "/3/movie/top_rated"
        }
    }
}