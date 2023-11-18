//
//  MovieRepository.swift
//  TheMovieDB
//
//  Created by Mohammad Zulqurnain on 15/11/2023.
//

import Foundation

protocol MovieRepositoryProtocol {
    var movieService: MovieServiceProtocol { get }
    var persistentStoreManager: PersistentStoreManagerProtocol { get }
    var networkMonitor: NetworkMonitorProtocol { get }
    
    func getPopularMovies(page: Int) async throws -> MovieResponse
    func saveMovieToPersistentStore(movie: Movie) async
    func getMovieDetails(for id: Int) async throws -> MovieDetails?
    func getMoviesFromPersistentStore() async -> [Movie]
}

// MARK: - MovieRepository

actor MovieRepository: MovieRepositoryProtocol {

    let movieService: MovieServiceProtocol
    let persistentStoreManager: PersistentStoreManagerProtocol
    let networkMonitor: NetworkMonitorProtocol
    
    init(movieService: MovieServiceProtocol, persistentStoreManager: PersistentStoreManagerProtocol, networkMonitor: NetworkMonitorProtocol) {
        self.movieService = movieService
        self.persistentStoreManager = persistentStoreManager
        self.networkMonitor = networkMonitor
    }
    
    func getPopularMovies(page: Int) async throws -> MovieResponse {
        
        if networkMonitor.isConnected {
            let movieResponse  = try await movieService.getPopularMovies(page)
            let fetchedMovies = movieResponse.movies.unique()

            Logger.logInfo(Self.self, "Successfully fetched PopularMovies: \(fetchedMovies) from the network")
            
            return MovieResponse(movies: fetchedMovies, totalPages: movieResponse.totalPages)
            
        } else {
    
            let storedMovies = await getMoviesFromPersistentStore()
            
            Logger.logInfo(Self.self, "Successfully fetched PopularMovies: \(storedMovies) from the Persistence Store")
            
            return MovieResponse(movies: storedMovies, totalPages: 0)
            
        }
    }
    
    func saveMovieToPersistentStore(movie: Movie) async {
        var storedMovies: [Movie] = await getMoviesFromPersistentStore()
        if !storedMovies.contains(movie) {
            storedMovies.append(movie)
            await persistentStoreManager.setObject(Constants.movies, value: storedMovies)
            
            Logger.logInfo(Self.self, "Successfully saved movie \(movie) to persistent store")
        }
    }
    
    func getMoviesFromPersistentStore() async -> [Movie] {
        await persistentStoreManager.getObject(Constants.movies, [Movie].self) ?? []
    }
    
    func getMovieDetails(for id: Int) async throws -> MovieDetails? {
        
        if networkMonitor.isConnected {
            let movieDetails = try await movieService.getMovieDetails(for: id)
          
            await persistentStoreManager.setObject("Movie:\(id)", value: movieDetails)
            
            Logger.logInfo(Self.self, "Successfully retrieved movie details from movieService \(movieDetails)")
            
            return movieDetails
        } else {
            
            guard let movieDetails = await persistentStoreManager.getObject("\(Constants.movie):\(id)", MovieDetails.self) else { return nil }
            
            Logger.logInfo(Self.self, "Successfully retrieved from persistence store \(movieDetails)")
            
            return movieDetails
        }
    }
}

