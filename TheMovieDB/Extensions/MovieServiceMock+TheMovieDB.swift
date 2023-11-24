//
//  MovieServiceMock+TheMovieDB.swift
//  TheMovieDB
//
//  Created by Mohammad Zulqurnain on 24/11/2023.
//

import Foundation

extension MovieServiceMock: Equatable {
    static func == (lhs: MovieServiceMock, rhs: MovieServiceMock) -> Bool {
        lhs === rhs
    }
}
