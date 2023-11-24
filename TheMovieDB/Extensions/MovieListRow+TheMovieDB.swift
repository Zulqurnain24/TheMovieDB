//
//  MovieListRow+TheMovieDB.swift
//  TheMovieDB
//
//  Created by Mohammad Zulqurnain on 24/11/2023.
//

import Foundation

extension MovieListRow: Equatable {
    static func == (lhs: MovieListRow, rhs: MovieListRow) -> Bool {
        lhs.movie == rhs.movie
    }
}
