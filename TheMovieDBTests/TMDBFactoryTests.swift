//
//  TMDBFactoryTests.swift
//  TheMovieDBTests
//
//  Created by Mohammad Zulqurnain on 24/11/2023.
//

import XCTest
@testable import TheMovieDB

// MARK: - TMDBFactoryTests

class TMDBFactoryTests: XCTestCase {
    
    func testCreateMovieDetailViewMock() {
        Task { @MainActor in
            XCTAssertEqual(TMDBFactory.createMovieDetailViewMock(), MovieDetailView(viewModel: TMDBFactory.createMovieDetailViewModelMock(), imageLoader: TMDBFactory.createImageLoaderMock(Constants.movieData)))
        }
    }
    
    func testJSONDecoder() {
        XCTAssertEqual(TMDBFactory.createDecoder(), JSONDecoder())
    }
    
    func testCreateImageView() {
        Task { @MainActor in
            XCTAssertEqual(TMDBFactory.createMovieImageView(pathUrl: nil, imageHeight: 50.0, imageWidth: 50.0, cornerRadius: 5.0), MovieImageView(imageUrl: nil, imageLoader: TMDBFactory.createImageLoader(), imageHeight: 50, imageWidth: 50, cornerRadius: 5.0))
        }
    }
    
    func testCreateMovieImageViewMock() {
        Task { @MainActor in
            XCTAssertEqual(TMDBFactory.createMovieImageViewMock(), MovieImageView(imageUrl: URL(string: Constants.movieImageMockUrlString), imageLoader: TMDBFactory.createImageLoaderMock(Constants.movieData), imageHeight: Constants.thumbnailDimension, imageWidth: Constants.thumbnailDimension, cornerRadius: Constants.cornerRadius))
        }
    }
    
    func testCreateMovieImageView() {
        Task { @MainActor in
            XCTAssertEqual(TMDBFactory.createMovieImageView(pathUrl: nil, imageHeight: 5.0, imageWidth: 5.0, cornerRadius: 5.0), MovieImageView(imageUrl: nil, imageLoader: TMDBFactory.createImageLoader(), imageHeight: 5.0, imageWidth: 5.0, cornerRadius: 5.0))
        }
    }
    
    func testCreateNetworkingManagerMock() {
        XCTAssertEqual(TMDBFactory.createNetworkingManagerMock(), NetworkingManagerMock.shared)
    }
    
    func testCreateNetworkingManager() {
        XCTAssertEqual(TMDBFactory.createNetworkingManager(), NetworkingManager.shared)
    }
    
    func testCreateMovieService() {
        Task { @MainActor in
            XCTAssertEqual(TMDBFactory.createMovieService(), MovieService(networkingManager: TMDBFactory.createNetworkingManager(), decoder: JSONDecoder()))
        }
    }
    
    func testCreatePersistentStoreManager() {
        Task { @MainActor in
            XCTAssertEqual(TMDBFactory.createPersistentStoreManager(), PersistentStoreManager())
        }
    }
    
    func testCreateNetworkMonitor() {
        Task { @MainActor in
            XCTAssertEqual(TMDBFactory.createNetworkMonitor(),  NetworkMonitor())
        }
    }
    
    func testCreateMovieRepository() {
        Task { @MainActor in
            XCTAssertEqual(TMDBFactory.createMovieRepository(),  MovieRepository(movieService: TMDBFactory.createMovieService(), persistentStoreManager: TMDBFactory.createPersistentStoreManager(), networkMonitor: TMDBFactory.createNetworkMonitor()))
        }
    }
    
    func testCreateMovieListViewModel() {
        Task { @MainActor in
            XCTAssertEqual(TMDBFactory.createMovieListViewModel(), MovieListViewModel(movieRepository: TMDBFactory.createMovieRepository()))
        }
    }
    
    func testCreateMovieDetailViewModel() {
        Task { @MainActor in
            XCTAssertEqual(TMDBFactory.createMovieDetailViewModel(movie: Movie.mock()), MovieDetailViewModel(movie: TMDBFactory.createMovieMock(), movieRepository: TMDBFactory.createMovieRepository()))
        }
    }
    
    func testCreateMovieDetailView() {
        Task { @MainActor in
            XCTAssertEqual(TMDBFactory.createMovieDetailView(movie: Movie.mock()), MovieDetailView(viewModel: TMDBFactory.createMovieDetailViewModel(movie: TMDBFactory.createMovieMock()), imageLoader: ImageLoader(persistentStoreManager: TMDBFactory.createPersistentStoreManager(), networkingManager: TMDBFactory.createNetworkingManager())))
        }
    }
    
    func testCreateMovieListView() {
        Task { @MainActor in
            XCTAssertEqual(TMDBFactory.createMovieListView(), MovieListView(viewModel: TMDBFactory.createMovieListViewModel()))
        }
    }
    
    func testCreateMovieListViewMock() {
        Task { @MainActor in
            XCTAssertEqual(TMDBFactory.createMovieListViewMock(), MovieListView(viewModel: TMDBFactory.createMovieListViewModelMock()))
        }
    }
    
    func testCreateMovieListRow() {
        XCTAssertEqual(TMDBFactory.createMovieListRow(movie: Movie.mock()), MovieListRow(movie: TMDBFactory.createMovieMock()))
    }
    
    func testcreateImageLoader() {
        Task { @MainActor in
            XCTAssertEqual(TMDBFactory.createImageLoader(), ImageLoader(persistentStoreManager: TMDBFactory.createPersistentStoreManager(), networkingManager: TMDBFactory.createNetworkingManager()))
        }
    }
    
    func testCreateMovieList() {
        Task { @MainActor in
            XCTAssertEqual(TMDBFactory.createMovieList(viewModel: TMDBFactory.createMovieListViewModel()), MovieList(viewModel: TMDBFactory.createMovieListViewModel()))
        }
    }
    
    func testCreateMovieListViewRow() {
        XCTAssertEqual(TMDBFactory.createMovieListViewRow(movie: TMDBFactory.createMovieMock(), onAppearAction: {}, onSegue: {}), MovieListViewRow(movie: Movie.mock(), onAppear: {}, onSegue: {}))
    }
    
    func testCreateNetworkMonitorMock() {
        XCTAssertEqual(TMDBFactory.createNetworkMonitorMock(), NetworkMonitorMock(isConnected: true, isMonitoring: false))
    }
    
    func testCreateMovieMock() {
        XCTAssertEqual(TMDBFactory.createMovieMock(), Movie(id: Constants.movieMockId, title: Constants.movieMockTitle, voteAverage: Constants.movieMockRating, releaseDate: Constants.movieMockDate, thumbnailPath: Constants.movieMockPath))
    }
    
    func testCreateMovieDetailsMock() {
        XCTAssertEqual(TMDBFactory.createMovieDetailsMock(),  MovieDetails(id: Constants.movieDetailsMockId, title: Constants.movieDetailsMockTitle, overview: Constants.movieDetailsMockOverview, posterPath: Constants.movieDetailsMockPath, voteAverage: Constants.movieDetailsMockVoteAverage, homepage: Constants.movieDetailsHomePage))
    }

    func testCreateMovieServiceMock() {
        Task { @MainActor in
            XCTAssertEqual(TMDBFactory.createMovieServiceMock(), MovieServiceMock())
        }
    }

    func testCreateMovieRepositoryMock() {
        Task { @MainActor in
            XCTAssertEqual(TMDBFactory.createMovieRepositoryMock(), MovieRepository(movieService: TMDBFactory.createMovieServiceMock(), persistentStoreManager: TMDBFactory.createPersistentStoreManagerMock(), networkMonitor: TMDBFactory.createNetworkMonitorMock()))
        }
    }

    func testCreatePersistentStoreManagerMock() {
        Task { @MainActor in
            XCTAssertEqual(TMDBFactory.createPersistentStoreManagerMock(), PersistentStoreManagerMock())
        }
    }

    func testCreateMovieListViewModelMock() {
        Task { @MainActor in
            XCTAssertEqual(TMDBFactory.createMovieListViewModelMock(), MovieListViewModel(movieRepository: TMDBFactory.createMovieRepositoryMock()))
        }
    }

    func testCreateMovieDetailViewModelMock() {
        Task { @MainActor in
            XCTAssertEqual(TMDBFactory.createMovieDetailViewModelMock(),  MovieDetailViewModel(movie: TMDBFactory.createMovieMock(), movieRepository: TMDBFactory.createMovieRepositoryMock()))
        }
    }

    func testCreateImageLoaderMock() {
        Task { @MainActor in
            let networkingManagerMock = TMDBFactory.createNetworkingManagerMock()
            networkingManagerMock.jsonFileName = "MovieData"
            
            XCTAssertEqual(TMDBFactory.createImageLoaderMock("MovieData"), ImageLoader(persistentStoreManager: PersistentStoreManagerMock(), networkingManager: networkingManagerMock))
        }
    }
}
