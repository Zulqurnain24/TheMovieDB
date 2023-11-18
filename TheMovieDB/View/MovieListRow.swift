//
//  MovieListRow.swift
//  TheMovieDB
//
//  Created by Mohammad Zulqurnain on 15/11/2023.
//

import SwiftUI

// MARK: - MovieListRow

struct MovieListRow: View {
    var movie: Movie
    @StateObject private var imageLoader: ImageLoader
    
    init(movie: Movie) {
        self.movie = movie
        self._imageLoader = StateObject(wrappedValue: TMDBFactory.createImageLoader())
    }
    
    var body: some View {
        HStack {
            TMDBFactory.createMovieImageView(thumbnailPathUrl: ImagesEndpoint.getThumbnail(movie.thumbnailPath).url, imageHeight: Constants.thumbnailDimension, imageWidth: Constants.thumbnailDimension, cornerRadius: Constants.cornerRadius)
            
            VStack(alignment: .leading, spacing: Constants.smallSpacing) {
                Text(movie.title)
                    .font(.headline)
                    .fontWeight(.bold)
                
                Text("\(Constants.ratingLabel) \(String(format: "%.1f", movie.voteAverage))")
                    .font(.subheadline)
                
                Text("\(Constants.releaseDateLabel) \(movie.releaseDate)")
                    .font(.subheadline)
            }
            .padding(.leading, Constants.smallPadding)
            
            Spacer()
        }
        .padding(Constants.smallPadding)
        .onAppear() {
            Task {
                do {
                    try await imageLoader.set(urlString: movie.thumbnailPath,
                                    type: .thumbnail)
                } catch {
                    throw error
                }
            }
        }
    }
}

#Preview {
    TMDBFactory.createMovieListRow(movie: TMDBFactory.createMovieMock())
}
