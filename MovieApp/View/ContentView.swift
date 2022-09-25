//
//  ContentView.swift
//  MovieApp
//
//  Created by Eashan on 13/9/22.
//

import SwiftUI

struct ContentView: View {
    
    @State private var queryText: String = ""
    @StateObject private var movieObservableObject = MovieObservableObject()
    
    var body: some View {
        NavigationView {
            List(movieObservableObject.movies, id: \.id) { movie in
                MovieRow(movie: movie)
                    .listRowSeparator(.hidden)
            }
            .searchable(text: $queryText, prompt: "Search movie title")
            .onChange(of: queryText, perform: { newValue in
                movieObservableObject.queryText = queryText
            })
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
