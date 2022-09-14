//
//  ContentView.swift
//  MovieApp
//
//  Created by Eashan on 13/9/22.
//

import SwiftUI

struct ContentView: View {
    
    @StateObject private var model = MoviesProvider()
    @State private var searchText = ""
    
    private var movies: [MovieViewModel] {
        if searchText.isEmpty {
            return model.movies
        } else {
            return model.movies.filter{$0.title.contains(searchText)}
        }
    }
    
    var body: some View {
        NavigationView {
            List(movies, id: \.id) { movie in
                MovieRow(movie: movie)
                    .listRowSeparator(.hidden)
            }
            .searchable(text: $searchText, prompt: "Search movie title")
            .listStyle(.plain)
            .navigationTitle("Top Rated Movie List")
            .navigationBarTitleDisplayMode(.large)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
