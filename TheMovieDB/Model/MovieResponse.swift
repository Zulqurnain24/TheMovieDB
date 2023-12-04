//
//  MovieResponse.swift
//  TheMovieDB
//
//  Created by Mohammad Zulqurnain on 15/11/2023.
//

// MARK: - MovieResponse

struct MovieResponse: Codable, Equatable {
    let movies: [Movie]
    let totalPages: Int

    enum CodingKeys: String, CodingKey {
        case movies = "results"
        case totalPages = "total_pages"
    }
}
