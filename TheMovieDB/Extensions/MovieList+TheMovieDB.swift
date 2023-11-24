//
//  MovieList+TheMovieDB.swift
//  TheMovieDB
//
//  Created by Mohammad Zulqurnain on 24/11/2023.
//

import Foundation

extension MovieList: Equatable {
    static func == (lhs: MovieList<ViewModel>, rhs: MovieList<ViewModel>) -> Bool {
        lhs.viewModel.filteredMovies == rhs.viewModel.filteredMovies
        &&
        lhs.viewModel.movies == rhs.viewModel.movies
        &&
        lhs.viewModel.searchText == rhs.viewModel.searchText
        &&
        lhs.viewModel.viewState == rhs.viewModel.viewState
    }
}
