//
//  ContentView.swift
//  MovieApp
//
//  Created by Eashan on 13/9/22.
//

import SwiftUI

struct ContentView: View {
    
    @StateObject private var model = MoviesProvider()
    
    var body: some View {
        NavigationView {
            List(model.movies, id: \.id) { movie in
                MovieRow(movie: movie)
                    .listRowSeparator(.hidden)
            }
            .listStyle(.plain)
            .navigationTitle("Movie List")
            .navigationBarTitleDisplayMode(.large)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
