//
//  MovieListView+TheMovieDB.swift
//  TheMovieDB
//
//  Created by Mohammad Zulqurnain on 24/11/2023.
//

import Foundation

extension MovieListView: Equatable {
    static func == (lhs: MovieListView<ViewModel>, rhs: MovieListView<ViewModel>) -> Bool {
        lhs.viewModel == rhs.viewModel
    }
}
