//
//  MoviesProvider.swift
//  MovieApp
//
//  Created by Eashan on 13/9/22.
//

import Foundation
import Combine

final class MovieObservableObject: ObservableObject {
    
    // MARK:- Subscribers
    private var cancellable: AnyCancellable?
    private var cancellables = Set<AnyCancellable>()
    
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
        self.queryText.isEmpty ? self.getMovie(.topRated) : self.searchMovies()
    }
    
    private func getMovies(_ movieFeed: MovieFeed) {
        cancellable = movieClient.getFeed(movieFeed)
            .sink(receiveCompletion: { _ in
            },
                  receiveValue: {
                self.movies = $0.results.map { MovieViewModel(movie: $0) }
            })
    }
    
    private func getMovie(_ movieFeed: MovieFeed) {
        movieClient.getMovieFeed(movieFeed)
            .sink { completion in
                switch completion {
                case .finished:
                    print("Finished")
                case .failure(let err):
                    print("Error is \(err.localizedDescription)")
                }
            } receiveValue: { movieData in
                self.movies = movieData.results.map { MovieViewModel(movie: $0) }
            }
            .store(in: &cancellables)
    }
    
    private func searchMovies() {
        cancellable = searchClient.searchMovie(.generic, query: queryText)
            .sink(receiveCompletion: { _ in
            }, receiveValue: {
                self.movies = $0.results.map { MovieViewModel(movie: $0) }
            })
    }
}

