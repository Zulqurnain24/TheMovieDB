//
//  MovieDetailViewModel.swift
//  TheMovieDB
//
//  Created by Mohammad Zulqurnain on 24/11/2023.
//

import Foundation

extension MovieDetailViewModel: Equatable {
    static func == (lhs: MovieDetailViewModel, rhs: MovieDetailViewModel) -> Bool {
        lhs.movie.id == rhs.movie.id
    }
}
