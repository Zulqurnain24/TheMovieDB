//
//  MovieDetailViewModel.swift
//  TheMovieDB
//
//  Created by Mohammad Zulqurnain on 15/11/2023.
//

import SwiftUI

protocol MovieDetailViewModelProtocol: ObservableObject {
    var movie: Movie { get }
    var movieDetails: MovieDetails? { get }

    func fetchMovieDetails() async
}

// MARK: - MovieDetailViewModel

final class MovieDetailViewModel: MovieDetailViewModelProtocol {

    @Published var movie: Movie
    @Published var movieDetails: MovieDetails?

    private let movieRepository: MovieRepositoryProtocol

    init(movie: Movie, movieRepository: MovieRepositoryProtocol) {
        self.movie = movie
        self.movieRepository = movieRepository
    }

    @MainActor
    func fetchMovieDetails() async {
        do {
            guard let movieDetails = try await movieRepository.getMovieDetails(for: movie.id) else { return }

            self.movieDetails = movieDetails

            Logger.logInfo(Self.self, "fetched movie details : \(movieDetails)")
        } catch {
            Logger.logError(Self.self, error)
        }
    }
}
