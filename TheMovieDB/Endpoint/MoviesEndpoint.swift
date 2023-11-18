//
//  Endpoint.swift
//  TheMovieDB
//
//  Created by Mohammad Zulqurnain on 15/11/2023.
//

import Foundation

// MARK: - MoviesEndpoint

enum MoviesEndpoint {
    case popularMovies(page: Int)
    case movieDetails(id: Int)

    var baseUrl: String {
        return "https://api.themoviedb.org/3/movie"
    }

    var apiKey: String {
        return "56a29f6d7010284157af93df3083d395"
    }

    var path: String {
        switch self {
        case .popularMovies:
            return "popular"
        case .movieDetails(let id):
            return "\(id)"
        }
    }

    var queryItems: [URLQueryItem] {
        switch self {
        case .popularMovies(let page):
            return [URLQueryItem(name: "api_key", value: apiKey),
                    URLQueryItem(name: "page", value: "\(page)")]
        case .movieDetails:
            return [URLQueryItem(name: "api_key", value: apiKey)]
        }
    }

    var url: URL? {
        var components = URLComponents(string: baseUrl)!
        components.path = "\(components.path)/\(path)"
        components.queryItems = queryItems
        return components.url
    }
}
