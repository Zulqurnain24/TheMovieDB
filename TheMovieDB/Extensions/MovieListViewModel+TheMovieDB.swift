//
//  MovieListViewModel+TheMovieDB.swift
//  TheMovieDB
//
//  Created by Mohammad Zulqurnain on 24/11/2023.
//

import Foundation

extension MovieListViewModel: Equatable {
    static func == (lhs: MovieListViewModel, rhs: MovieListViewModel) -> Bool {
        lhs.movies == rhs.movies
        &&
        lhs.filteredMovies == rhs.filteredMovies
        &&
        lhs.viewState == rhs.viewState
        &&
        lhs.searchText == rhs.searchText
        &&
        lhs.currentPage == rhs.currentPage
    }
}
