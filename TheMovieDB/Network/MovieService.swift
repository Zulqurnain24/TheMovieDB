//
//  MovieService.swift
//  TheMovieDB
//
//  Created by Mohammad Zulqurnain on 15/11/2023.
//

import Foundation

protocol MovieServiceProtocol {
    func getPopularMovies(_ page: Int) async throws -> MovieResponse
    func getMovieDetails(for id: Int) async throws -> MovieDetails
}

// MARK: - MovieService

actor MovieService: MovieServiceProtocol {

    enum NetworkError: Error, Equatable {
        case invalidURL
        case decodingError
    }

    private let networkingManager: NetworkingManagerProtocol

    private let decoder: JSONDecoder

    init(networkingManager: NetworkingManagerProtocol, decoder: JSONDecoder) {
        self.networkingManager = networkingManager
        self.decoder = decoder
    }

    func getPopularMovies(_ page: Int) async throws -> MovieResponse {

        guard let url = MoviesEndpoint.popularMovies(page: page).url else {
            throw NetworkError.invalidURL }

        do {
            let movieResponse = try await networkingManager.request(url: url, session: .shared, type: MovieResponse.self)

            return movieResponse
        } catch {
            Logger.logError(Self.self, error)

            throw error
        }
    }

    func getMovieDetails(for id: Int) async throws -> MovieDetails {

        guard let url = MoviesEndpoint.movieDetails(id: id).url else {
            throw NetworkError.invalidURL }

        do {
            let movieDetails = try await networkingManager.request(url: url, session: .shared, type: MovieDetails.self)
            return movieDetails
        } catch {
            Logger.logError(Self.self, error)

            throw error
        }
    }
}
