//
//  MovieRow.swift
//  MovieApp
//
//  Created by Eashan on 13/9/22.
//


import SwiftUI
import Combine

struct MovieRow: View {
    
    let movie: MovieViewModel
    
    var body: some View {
        HStack(alignment: .top, spacing: 20) {
            ImageViewCache(urls: (urlString: movie.posterPathHighResURLString,
                                  lowResURLString: movie.posterPathLowResURLString),
                           errorImage: UIImage(systemName: "text.below.photo.fill"))
            .clipShape(RoundedRectangle(cornerRadius: 10))
            .aspectRatio(contentMode: .fit)
            .frame(width: 100, height: 150)
            
            VStack(alignment: .leading, spacing: 10.0) {
                Text(movie.title)
                    .font(.system(size: 20, weight: .bold))
                Text(movie.overview)
                    .font(.subheadline)
                    .foregroundColor(Color(#colorLiteral(red: 0.501960814, green: 0.501960814, blue: 0.501960814, alpha: 1)))
                Text(movie.releaseDate)
                    .font(.caption)
                    .fontWeight(.bold)
                    .foregroundColor(.secondary)
            }
        }
        .padding(12)
    }
}
