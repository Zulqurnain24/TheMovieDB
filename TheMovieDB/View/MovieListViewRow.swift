//
//  MovieListViewRow.swift
//  TheMovieDB
//
//  Created by Mohammad Zulqurnain on 16/11/2023.
//

import SwiftUI

// MARK: - MovieListViewRow

struct MovieListViewRow: View {
    let movie: Movie
    let onAppear: () -> Void
    let onSegue: () -> Void

    var body: some View {
        NavigationLink(destination: TMDBFactory.createMovieDetailView(movie: movie)
            .onAppear(perform: onSegue)) {
                TMDBFactory.createMovieListRow(movie: movie)
                    .onAppear(perform: onAppear)

            }
    }
}

#Preview {
    TMDBFactory.createMovieListViewMock()
}
