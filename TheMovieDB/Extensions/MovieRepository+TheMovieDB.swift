//
//  MovieRepository+TheMovieDB.swift
//  TheMovieDB
//
//  Created by Mohammad Zulqurnain on 24/11/2023.
//

import Foundation

extension MovieRepository: Equatable {
    static func == (lhs: MovieRepository, rhs: MovieRepository) -> Bool {
        lhs === rhs
    }
}
