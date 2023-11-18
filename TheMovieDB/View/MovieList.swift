//
//  MovieList.swift
//  TheMovieDB
//
//  Created by Mohammad Zulqurnain on 16/11/2023.
//

import SwiftUI

struct MovieList<ViewModel: MovieListViewModelProtocol>: View {
    @ObservedObject var viewModel: ViewModel
    
    var body: some View {
        List(viewModel.filteredMovies.unique(), id: \.id) { movie in
            TMDBFactory.createMovieListViewRow(movie: movie) {
                Task {
                    if await viewModel.hasReachedEnd(of: movie) && viewModel.viewState != .fetching {
                        await viewModel.fetchNextMovie()
                    }
                }
            } onSegue: {
                Task {
                    await viewModel.saveMovieToPersistentStore(movie: movie)
                }
            }
        }
        .scrollIndicators(.hidden, axes: [.vertical, .horizontal])
        .accessibilityIdentifier(Constants.movieListIdentifier)
    }
}

#Preview {
    TMDBFactory.createMovieList(viewModel: TMDBFactory.createMovieListViewModelMock())
}
