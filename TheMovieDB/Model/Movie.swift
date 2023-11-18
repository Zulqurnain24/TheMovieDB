//
//  Movie.swift
//  TheMovieDB
//
//  Created by Mohammad Zulqurnain on 15/11/2023.
//

import Foundation

// MARK: - Movie

struct Movie: Identifiable, Codable, Hashable {
    let id: Int
    let title: String
    let voteAverage: Double
    let releaseDate: String
    let thumbnailPath: String
    
    enum CodingKeys: String, CodingKey {
        case id
        case title
        case releaseDate = "release_date"
        case thumbnailPath = "backdrop_path"
        case voteAverage = "vote_average"
    }
}
