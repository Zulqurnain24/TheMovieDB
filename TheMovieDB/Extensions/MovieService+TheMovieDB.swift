//
//  MovieService+TheMovieDB.swift
//  TheMovieDB
//
//  Created by Mohammad Zulqurnain on 24/11/2023.
//

import Foundation

extension MovieService: Equatable {
    static func == (lhs: MovieService, rhs: MovieService) -> Bool {
        lhs === rhs
    }
}
