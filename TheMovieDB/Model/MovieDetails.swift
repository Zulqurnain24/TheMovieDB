//
//  MovieDetails.swift
//  TheMovieDB
//
//  Created by Mohammad Zulqurnain on 15/11/2023.
//

// MARK: - MovieDetails

struct MovieDetails: Codable, Equatable {
    let id: Int
    let title: String
    let overview: String
    let posterPath: String?
    let voteAverage: Double
    let homepage: String

    enum CodingKeys: String, CodingKey {
        case id
        case title
        case overview
        case posterPath = "poster_path"
        case voteAverage = "vote_average"
        case homepage
    }
}
