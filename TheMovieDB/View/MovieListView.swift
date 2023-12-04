//
//  MovieListView.swift
//  TheMovieDB
//
//  Created by Mohammad Zulqurnain on 15/11/2023.
//

import Combine
import SwiftUI

// MARK: - MovieListView

@MainActor
struct MovieListView<ViewModel: MovieListViewModelProtocol>: View {
    @ObservedObject var viewModel: ViewModel

    var body: some View {
        NavigationView {
            VStack(alignment: .leading) {
                Text(verbatim: Constants.popularMovies)
                    .font(.largeTitle)
                    .padding([.horizontal, .bottom])
                    .accessibilityIdentifier("popularMoviesText")

                TextField(Constants.searchMovies, text: $viewModel.searchText)
                    .padding([.horizontal])
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .onReceive(Just(viewModel.searchText)) { newState in
                        Task {
                            await viewModel.filterMovies(by: newState)
                        }
                    }
                    .accessibilityIdentifier("searchMoviesTextField")

                if viewModel.filteredMovies.isEmpty {
                    Text(verbatim: Constants.connectToInternet)
                        .padding()
                    Spacer()
                        .frame(maxHeight: .infinity)
                } else if let viewModel = viewModel as? MovieListViewModel {
                    TMDBFactory.createMovieList(viewModel: viewModel)
                }
            }
            .navigationBarHidden(true)
            .task {
                await viewModel.fetchMovies()
            }
        }
    }
}

#Preview {
    TMDBFactory.createMovieListViewMock()
}
