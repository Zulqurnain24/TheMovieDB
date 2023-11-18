//
//  MovieDetailsMock.swift
//  TheMovieDB
//
//  Created by Mohammad Zulqurnain on 16/11/2023.
//

// MARK: - MovieDetailsMock

extension MovieDetails {
    static func mock() -> Self {
        MovieDetails(id: Constants.movieDetailsMockId, title: Constants.movieDetailsMockTitle, overview: Constants.movieDetailsMockOverview, posterPath: Constants.movieDetailsMockPath, voteAverage: Constants.movieDetailsMockVoteAverage, homepage: Constants.movieDetailsHomePage)
    }
}
