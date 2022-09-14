//
//  SearchMovieFeed.swift
//  MovieApp
//
//  Created by Eashan on 14/9/22.
//

import Foundation

enum SearchMovie {
    case topRated
}

extension SearchMovie: Endpoint {
    
    var base: String {
        return "https://api.themoviedb.org"
    }
    
    var path: String {
        switch self {
        case .topRated: return "/3/search/movie"
        }
    }
}
