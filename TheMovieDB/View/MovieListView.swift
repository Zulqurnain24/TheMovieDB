//
//  MovieListView.swift
//  TheMovieDB
//
//  Created by Mohammad Zulqurnain on 15/11/2023.
//

import Combine
import SwiftUI

// MARK: - MovieListView

struct MovieListView<ViewModel: MovieListViewModelProtocol>: View {
    @StateObject var viewModel: ViewModel
    
    var body: some View {
        NavigationView {
            VStack(alignment: .leading) {
                Text(verbatim: Constants.popularMovies)
                    .font(.largeTitle)
                    .padding([.horizontal, .bottom])
                    .accessibilityIdentifier(Constants.popularMoviesTextIdentifier)
                
                TextField(Constants.searchMovies, text: $viewModel.searchText)
                    .padding([.horizontal])
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .onReceive(Just(viewModel.searchText)) { newState in
                        Task {
                            await viewModel.filterMovies(by: newState)
                        }
                    }
                    .accessibilityIdentifier(Constants.searchMoviesTextfieldAccessIdentifier)
                
                if viewModel.filteredMovies.isEmpty {
                    Text(verbatim: Constants.connectToInternet)
                        .padding()
                        .accessibilityIdentifier(Constants.connectToInternetTextAccessIdentifier)
                    Spacer()
                        .frame(maxHeight: .infinity)
                } else {
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
