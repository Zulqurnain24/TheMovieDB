//
//  Factory.swift
//  TheMovieDB
//
//  Created by Mohammad Zulqurnain on 16/11/2023.
//

import Foundation
import SwiftUI

class TMDBFactory {
    
    static func createDecoder() -> JSONDecoder {
        JSONDecoder()
    }
    
    @MainActor static func createMovieImageView(thumbnailPathUrl: URL?, imageHeight: CGFloat, imageWidth: CGFloat, cornerRadius: CGFloat) -> MovieImageView {
        MovieImageView(imageUrl: thumbnailPathUrl, imageLoader: createImageLoader(), imageHeight: imageHeight, imageWidth: imageWidth, cornerRadius: cornerRadius)
    }
    
    @MainActor static func createMovieImageViewMock() -> MovieImageView {
        MovieImageView(imageUrl: URL(string: Constants.movieImageMockUrlString), imageLoader: createImageLoaderMock(Constants.movieData), imageHeight: Constants.thumbnailDimension, imageWidth: Constants.thumbnailDimension, cornerRadius: Constants.cornerRadius)
    }
    
    static func createNetworkingManagerMock() -> NetworkingManagerMock {
        NetworkingManagerMock.shared
    }
    
    static func createNetworkingManager() -> NetworkingManager {
        NetworkingManager.shared
    }
    
    @MainActor static func createMovieService() -> MovieService {
        MovieService(networkingManager: createNetworkingManager(), decoder: JSONDecoder())
    }
    
    @MainActor static func createPersistentStoreManager() -> PersistentStoreManager {
        PersistentStoreManager()
    }
    
    @MainActor static func createNetworkMonitor() -> NetworkMonitorProtocol {
        NetworkMonitor()
    }
    
    @MainActor static func createMovieRepository() -> MovieRepository {
        MovieRepository(movieService: createMovieService(), persistentStoreManager: createPersistentStoreManager(), networkMonitor: createNetworkMonitor())
    }
    
    @MainActor static func createMovieListViewModel() -> MovieListViewModel {
        MovieListViewModel(movieRepository: createMovieRepository())
    }
    
    @MainActor static func createMovieDetailViewModel(movie: Movie) -> MovieDetailViewModel {
        MovieDetailViewModel(movie: movie, movieRepository: createMovieRepository())
    }
    
    @MainActor static func createMovieDetailView(movie: Movie) -> some View {
        MovieDetailView(viewModel: createMovieDetailViewModel(movie: movie), imageLoader: ImageLoader(persistentStoreManager: createPersistentStoreManager(), networkingManager: createNetworkingManager()))
    }
    
    @MainActor static func createMovieListView() -> some View {
        MovieListView(viewModel: createMovieListViewModel())
    }
    
    @MainActor static func createMovieListViewMock() -> some View {
        MovieListView(viewModel: createMovieListViewModelMock())
    }
    
    static func createMovieListRow(movie: Movie) -> some View {
        MovieListRow(movie: movie)
    }
    
    @MainActor static func createImageLoader() -> ImageLoader {
        ImageLoader(persistentStoreManager: createPersistentStoreManager(), networkingManager: createNetworkingManager())
    }
    
    static func createMovieList(viewModel: some MovieListViewModelProtocol) -> some View {
        MovieList(viewModel: viewModel)
    }
    
    static func createMovieListViewRow(movie: Movie, onAppearAction: @escaping () -> Void, onSegue: @escaping () -> Void) -> some View {
        MovieListViewRow(movie: movie, onAppear: onAppearAction, onSegue: onSegue)
    }
    
    static func createNetworkMonitorMock() -> NetworkMonitorMock {
        return NetworkMonitorMock(isConnected: true, isMonitoring: false)
    }
    
    static func createMovieMock() -> Movie {
        return Movie.mock()
    }
    
    static func createMovieDetailsMock() -> MovieDetails {
        return MovieDetails.mock()
    }
    
    static func createMovieServiceMock() -> MovieServiceMock {
        MovieServiceMock()
    }
    
    static func createMovieRepositoryMock() -> MovieRepositoryProtocol {
        MovieRepository(movieService: createMovieServiceMock(), persistentStoreManager: createPersistentStoreManagerMock(), networkMonitor: createNetworkMonitorMock())
    }
    
    static func createPersistentStoreManagerMock() -> PersistentStoreManagerMock {
        PersistentStoreManagerMock()
    }
    
    static func createMovieListViewModelMock() -> MovieListViewModel {
        MovieListViewModel(movieRepository: createMovieRepositoryMock())
    }
    
    @MainActor static func createMovieDetailViewMock() -> some View {
        MovieDetailView(viewModel: createMovieDetailViewModelMock(), imageLoader: createImageLoaderMock(Constants.movieData))
    }
    
    static func createMovieDetailViewModelMock() -> MovieDetailViewModel {
        MovieDetailViewModel(movie: createMovieMock(), movieRepository: createMovieRepositoryMock())
    }
    
    @MainActor static func createImageLoaderMock(_ jsonFileName: String) -> ImageLoader {
        let networkingManagerMock = createNetworkingManagerMock()
        networkingManagerMock.jsonFileName = jsonFileName
        
        return ImageLoader(persistentStoreManager: PersistentStoreManagerMock(), networkingManager: networkingManagerMock)
    }
}
