//
//  MovieMock.swift
//  TheMovieDB
//
//  Created by Mohammad Zulqurnain on 15/11/2023.
//

import Foundation

// MARK: - MovieMock

extension Movie {
    static func mock() -> Self {
        Movie(id: Constants.movieMockId, title: Constants.movieMockTitle, voteAverage: Constants.movieMockRating, releaseDate: Constants.movieMockDate, thumbnailPath: Constants.movieMockPath)
    }
}
