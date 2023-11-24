//
//  MovieListViewModel.swift
//  TheMovieDB
//
//  Created by Mohammad Zulqurnain on 15/11/2023.
//

import SwiftUI

protocol MovieListViewModelProtocol: ObservableObject, Equatable {
    var movies: [Movie] { get set }
    var filteredMovies: [Movie] { get set }
    var searchText: String { get set }
    var totalPages: Int { get set }
    var currentPage: Int { get set }
    var viewState: MovieListViewModel.ViewState { get set }
    
    func fetchNextMovie() async
    func filterMovies(by name: String) async 
    func getMovie(at index: Int) async -> Movie?
    func hasReachedEnd(of movie: Movie) async -> Bool
    func fetchMovies() async
    func saveMovieToPersistentStore(movie: Movie) async
}

// MARK: - MovieListViewModel

final class MovieListViewModel: MovieListViewModelProtocol {
    private let movieRepository: MovieRepositoryProtocol
    
    @Published var totalPages: Int = 0
    @Published var currentPage: Int = 1
    @Published var viewState: ViewState = .loading
    
    @Published var movies: [Movie] = []
    @Published var filteredMovies: [Movie] = []
    @Published  var searchText: String = ""
    
    init(movieRepository: MovieRepositoryProtocol) {
        self.movieRepository = movieRepository
    }
    
    @MainActor
    func fetchMovies() async {
        do {
            reset()
            
            let movieResponse = try await movieRepository.getPopularMovies(page: currentPage)
            let movies = movieResponse.movies.unique()
            self.movies += movies
            self.filteredMovies += movies
            self.totalPages = movieResponse.totalPages
            
            viewState = .finished
            
            Logger.logInfo(Self.self, "fetched movies: \(self.movies) & total pages : \(self.totalPages)")
            
        } catch {
            Logger.logError(Self.self, error)
        }
    }
    
    @MainActor
    func fetchNextMovie() async {
        guard currentPage < totalPages else { return }
        
        viewState = .fetching
        defer { viewState = .finished }
        
        currentPage += 1
        
        await fetchMovies()
    }
    
    func saveMovieToPersistentStore(movie: Movie) async {
        await movieRepository.saveMovieToPersistentStore(movie: movie)
    }
    
    @MainActor
    func hasReachedEnd(of movie: Movie) -> Bool {
        movies.last?.id == movie.id
    }
    
    @MainActor
    func filterMovies(by name: String) async {
        if name.isEmpty {
            filteredMovies = movies
        } else {
            filteredMovies = movies.filter {
                if name.count == 1 {
                    "\($0.title.lowercased().first ?? Character(""))".contains(name.lowercased())
                } else {
                    $0.title.lowercased().contains(name.lowercased())
                }
            }
            
            Logger.logInfo(Self.self, "filtered movies \(filteredMovies) for \(name)")
        }
    }
    
    func getMovie(at index: Int) -> Movie? {
        guard index < filteredMovies.count else { return nil }
        
        Logger.logInfo(Self.self, "get movie \(filteredMovies[index]) for index \(index)")
        
        return filteredMovies[index]
    }
}

extension MovieListViewModel {
    enum ViewState {
        case fetching
        case loading
        case finished
    }
}

private extension MovieListViewModel {
    func reset() {
        if viewState == .finished {
            movies.removeAll()
            currentPage = 1
            totalPages = 0
            viewState = .loading
        }
    }
}
