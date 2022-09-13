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
    
    var body: some View {
        NavigationView {
            List(model.movies, id: \.id) { movie in
                MovieRow(movie: movie)
                    .listRowSeparator(.hidden)
            }
            .searchable(text: $searchText)
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
