//
//  ImagesEndpoint.swift
//  TheMovieDB
//
//  Created by Mohammad Zulqurnain on 16/11/2023.
//

import Foundation

// MARK: - ImagesEndpoint

enum ImagesEndpoint {
    case getThumbnail(_ name: String)
    case getPosterImage(_ name: String)

    var baseUrl: String {
        return "https://image.tmdb.org/t/p"
    }

    var apiKey: String {
        return "56a29f6d7010284157af93df3083d395"
    }

    var dimension: String {
        switch self {
        case .getPosterImage:
            "w300"
        case .getThumbnail:
            "w200"
        }
    }

    var name: String {
        switch self {
        case .getPosterImage(let name), .getThumbnail(let name):
            name
        }
    }

    var url: URL? {
        return URL(string: "\(baseUrl)/\(dimension)\(name)")
    }
}
