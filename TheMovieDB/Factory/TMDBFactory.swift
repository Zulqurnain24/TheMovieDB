//
//  Factory.swift
//  TheMovieDB
//
//  Created by Mohammad Zulqurnain on 16/11/2023.
//

import Foundation
import SwiftUI

protocol TMDBFactoryProtocol {
    static func createDecoder() -> JSONDecoder

    @MainActor static func createMovieImageView(pathUrl: URL?, imageHeight: CGFloat, imageWidth: CGFloat, cornerRadius: CGFloat) -> MovieImageView

    @MainActor static func createMovieImageViewMock() -> MovieImageView

    static func createNetworkingManagerMock() -> NetworkingManagerMock

    static func createNetworkingManager() -> NetworkingManager

    @MainActor static func createMovieService() -> MovieService

    @MainActor static func createPersistentStoreManager() -> PersistentStoreManager

    @MainActor static func createNetworkMonitor() -> NetworkMonitor

    @MainActor static func createMovieRepository() -> MovieRepository

    @MainActor static func createMovieListViewModel() -> MovieListViewModel

    @MainActor static func createMovieDetailViewModel(movie: Movie) -> MovieDetailViewModel

    @MainActor static func createMovieDetailView(movie: Movie) -> MovieDetailView<MovieDetailViewModel>

    @MainActor static func createMovieListView() -> MovieListView<MovieListViewModel>

    @MainActor static func createMovieListViewMock() -> MovieListView<MovieListViewModel>

    static func createMovieListRow(movie: Movie) -> MovieListRow

    @MainActor static func createImageLoader() -> ImageLoader

    static func createMovieList(viewModel: MovieListViewModel) -> MovieList< MovieListViewModel>

    static func createMovieListViewRow(movie: Movie, onAppearAction: @escaping () -> Void, onSegue: @escaping () -> Void) -> MovieListViewRow

    static func createNetworkMonitorMock() -> NetworkMonitorMock

    static func createMovieMock() -> Movie

    static func createMovieDetailsMock() -> MovieDetails

    static func createMovieServiceMock() -> MovieServiceMock

    static func createMovieRepositoryMock() -> MovieRepository

    static func createPersistentStoreManagerMock() -> PersistentStoreManagerMock

    static func createMovieListViewModelMock() -> MovieListViewModel

    @MainActor static func createMovieDetailViewMock() -> MovieDetailView<MovieDetailViewModel>

    static func createMovieDetailViewModelMock() -> MovieDetailViewModel

    @MainActor static func createImageLoaderMock(_ jsonFileName: String) -> ImageLoader
}

// MARK: - TMDBFactory

enum TMDBFactory: TMDBFactoryProtocol {
    static func createMovieDetailViewMock() -> MovieDetailView<MovieDetailViewModel> {
        MovieDetailView(viewModel: createMovieDetailViewModelMock(), imageLoader: createImageLoaderMock(Constants.movieData))
    }

    static func createDecoder() -> JSONDecoder {
        JSONDecoder()
    }

    @MainActor static func createMovieImageView(pathUrl: URL?, imageHeight: CGFloat, imageWidth: CGFloat, cornerRadius: CGFloat) -> MovieImageView {
        MovieImageView(imageUrl: pathUrl, imageLoader: createImageLoader(), imageHeight: imageHeight, imageWidth: imageWidth, cornerRadius: cornerRadius)
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

    @MainActor static func createNetworkMonitor() -> NetworkMonitor {
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

    @MainActor static func createMovieDetailView(movie: Movie) -> MovieDetailView<MovieDetailViewModel> {
        MovieDetailView(viewModel: createMovieDetailViewModel(movie: movie), imageLoader: ImageLoader(persistentStoreManager: createPersistentStoreManager(), networkingManager: createNetworkingManager()))
    }

    @MainActor static func createMovieListView() -> MovieListView<MovieListViewModel> {
        MovieListView(viewModel: createMovieListViewModel())
    }

    @MainActor static func createMovieListViewMock() -> MovieListView<MovieListViewModel> {
        MovieListView(viewModel: createMovieListViewModelMock())
    }

    static func createMovieListRow(movie: Movie) -> MovieListRow {
        MovieListRow(movie: movie)
    }

    @MainActor static func createImageLoader() -> ImageLoader {
        ImageLoader(persistentStoreManager: createPersistentStoreManager(), networkingManager: createNetworkingManager())
    }

    static func createMovieList(viewModel: MovieListViewModel) -> MovieList< MovieListViewModel> {
        MovieList(viewModel: viewModel)
    }

    static func createMovieListViewRow(movie: Movie, onAppearAction: @escaping () -> Void, onSegue: @escaping () -> Void) -> MovieListViewRow {
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

    static func createMovieRepositoryMock() -> MovieRepository {
        MovieRepository(movieService: createMovieServiceMock(), persistentStoreManager: createPersistentStoreManagerMock(), networkMonitor: createNetworkMonitorMock())
    }

    static func createPersistentStoreManagerMock() -> PersistentStoreManagerMock {
        PersistentStoreManagerMock()
    }

    static func createMovieListViewModelMock() -> MovieListViewModel {
        MovieListViewModel(movieRepository: createMovieRepositoryMock())
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
