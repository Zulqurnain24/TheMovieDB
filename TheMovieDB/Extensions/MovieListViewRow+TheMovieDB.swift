//
//  MovieListViewRow+TheMovieDB.swift
//  TheMovieDB
//
//  Created by Mohammad Zulqurnain on 24/11/2023.
//

import Foundation

extension MovieListViewRow: Equatable {
    static func == (lhs: MovieListViewRow, rhs: MovieListViewRow) -> Bool {
        lhs.movie == rhs.movie
    }
}
