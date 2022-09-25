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
