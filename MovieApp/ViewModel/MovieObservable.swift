//
//  MoviesProvider.swift
//  MovieApp
//
//  Created by Eashan on 13/9/22.
//

import Foundation
import Combine

final class MovieObservable: ObservableObject {
    
    // MARK:- Subscribers
    private var cancellable: AnyCancellable?
    
    // MARK:- Publishers
    @Published var movies: [MovieViewModel] = []
    
    @Published var queryText: String = "" {
        didSet {
            self.initialSetup()
        }
    }
    
    // MARK:- Private properties
    private let movieClient = MovieClient()
    private let searchClient = SearchClient()
    
    init() {
        self.initialSetup()
    }
    
    private func initialSetup() {
        self.queryText.isEmpty ? self.getMovies(.topRated) : self.searchMovies()
    }
    
    private func getMovies(_ movieFeed: MovieFeed) {
        cancellable = movieClient.getFeed(movieFeed)
            .sink(receiveCompletion: { _ in
                // Here the actual subscriber is created. As mentioned earlier, the sink-subscriber comes with a closure, that lets us handle the received value when it’s ready from the publisher.
            },
                  receiveValue: {
                self.movies = $0.results.map { MovieViewModel(movie: $0) }
            })
    }
    
    private func searchMovies() {
        cancellable = searchClient.searchMovie(.generic, query: queryText)
            .sink(receiveCompletion: { _ in
            }, receiveValue: {
                self.movies = $0.results.map { MovieViewModel(movie: $0) }
            })
    }
}

