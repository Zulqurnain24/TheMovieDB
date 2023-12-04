//
//  MovieServiceMock.swift
//  TheMovieDB
//
//  Created by Mohammad Zulqurnain on 16/11/2023.
//

import Foundation

// MARK: - MovieServiceMock

actor MovieServiceMock: MovieServiceProtocol {

    var movieList: [Movie]
    var filterList: [Movie]
    var movieDetails: MovieDetails?
    var totalPages: Int

    init(movieList: [Movie] = [], filterList: [Movie] = [], movieDetails: MovieDetails? = nil, totalPages: Int = 0) {
        self.movieList = movieList
        self.filterList = filterList
        self.movieDetails = movieDetails
        self.totalPages = totalPages
    }

    func getPopularMovies(_ page: Int) async throws -> MovieResponse {
        return MovieResponse(movies: movieList, totalPages: totalPages)
    }

    func getMovieDetails(for id: Int) async throws -> MovieDetails {
        return movieDetails!
    }

    func filterMovies(by name: String) async throws -> [Movie] {
        return filterList
    }
}
