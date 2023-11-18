//
//  MovieListViewModelTests.swift
//  TheMovieDBTests
//
//  Created by Mohammad Zulqurnain on 16/11/2023.
//

import XCTest
@testable import TheMovieDB

class MovieListViewModelTests: XCTestCase {
    
    var sut: MovieListViewModel!
    
    @MainActor override func setUp() {
        super.setUp()
    }
    
    override func tearDown() {
        sut = nil
        
        super.tearDown()
    }
    
    func testFetchMoviesWhenInternetAvailable() async throws {

        let movie1 = Movie(id: 1, title: "Avatar 2", voteAverage: 5.5, releaseDate: "2024-10-15", thumbnailPath: "/nohrh9aHNB1ehXmdtTZV5vStzcs.jpg")
        let movie2 = Movie(id: 2, title: "Inception", voteAverage: 3.5, releaseDate: "2024-10-25", thumbnailPath: "/nohrh9aHNB1ehXmdtTZV5vStzcr.jpg")
        
        let movieServiceMock = MovieServiceMock(movieList: [movie1, movie2], totalPages: 1)
        
        let movieRepositoryMock = MovieRepository(movieService: movieServiceMock, persistentStoreManager: TMDBFactory.createPersistentStoreManagerMock(), networkMonitor: TMDBFactory.createNetworkMonitorMock())
        
        sut = MovieListViewModel(movieRepository: movieRepositoryMock)
     
        _ = await sut.fetchMovies()
        
        XCTAssertEqual(sut.movies, [TheMovieDB.Movie(id: 1, title: "Avatar 2", voteAverage: 5.5, releaseDate: "2024-10-15", thumbnailPath: "/nohrh9aHNB1ehXmdtTZV5vStzcs.jpg"), TheMovieDB.Movie(id: 2, title: "Inception", voteAverage: 3.5, releaseDate: "2024-10-25", thumbnailPath: "/nohrh9aHNB1ehXmdtTZV5vStzcr.jpg")], "Content which has been mocked")
        XCTAssertEqual(sut.filteredMovies, [TheMovieDB.Movie(id: 1, title: "Avatar 2", voteAverage: 5.5, releaseDate: "2024-10-15", thumbnailPath: "/nohrh9aHNB1ehXmdtTZV5vStzcs.jpg"), TheMovieDB.Movie(id: 2, title: "Inception", voteAverage: 3.5, releaseDate: "2024-10-25", thumbnailPath: "/nohrh9aHNB1ehXmdtTZV5vStzcr.jpg")], "Content which has been mocked")
        XCTAssertEqual(sut.viewState, .finished, "Status should be finised")
        XCTAssertEqual(sut.searchText, "", "Search text should be empty")
    }
    
    func testFetchMoviesWhenInternetNotAvailableAndPersistanceStoreIsEmpty() async {

        let networkMonitorMock = NetworkMonitorMock(isConnected: false, isMonitoring: false)
        
        let movieRepositoryMock = MovieRepository(movieService: TMDBFactory.createMovieServiceMock(), persistentStoreManager: TMDBFactory.createPersistentStoreManagerMock(), networkMonitor: NetworkMonitorMock(isConnected: true, isMonitoring: false))
        
        sut = MovieListViewModel(movieRepository: movieRepositoryMock)
        
        networkMonitorMock.isConnected = false
       
        _ = await sut.fetchMovies()
        
        // Assert
        XCTAssertEqual(sut.movies, [])
        XCTAssertEqual(sut.filteredMovies, [])
        XCTAssertEqual(sut.viewState, .finished)
        XCTAssertEqual(sut.searchText, "", "Search text should be empty")
    }
    
    func testFetchMoviesWhenInternetNotAvailableAndPersistanceStoreIsNotEmpty() async {
  
        let networkMonitorMock = NetworkMonitorMock(isConnected: false, isMonitoring: false)
        
        let persistentStoreMock = TMDBFactory.createPersistentStoreManagerMock()
        
        let movieRepositoryMock = MovieRepository(movieService: TMDBFactory.createMovieServiceMock(), persistentStoreManager: persistentStoreMock, networkMonitor: networkMonitorMock)
        
        persistentStoreMock.setObject("Movies", value: [Movie.mock()])
        
        sut = MovieListViewModel(movieRepository: movieRepositoryMock)
        
        networkMonitorMock.isConnected = false
        
        _ = await sut.fetchMovies()
        
        XCTAssertEqual(sut.movies, [TheMovieDB.Movie(id: 123, title: "Mocked Title", voteAverage: 5.5, releaseDate: "2021-10-13", thumbnailPath: "/nohrh9aHNB1ehXmdtTZV5vStzcs.jpg")])
        XCTAssertEqual(sut.filteredMovies, [TheMovieDB.Movie(id: 123, title: "Mocked Title", voteAverage: 5.5, releaseDate: "2021-10-13", thumbnailPath: "/nohrh9aHNB1ehXmdtTZV5vStzcs.jpg")])
        XCTAssertEqual(sut.viewState, .finished)
        XCTAssertEqual(sut.searchText, "", "Search text should be empty")
    }
    
    @MainActor func testFilterMoviesEmptySearchText() async {
        sut = TMDBFactory.createMovieListViewModelMock()
        
        sut.movies = [Movie(id: 1, title: "Movie 2", voteAverage: 5.5, releaseDate: "2024-10-15", thumbnailPath: "/nohrh9aHNB1ehXmdtTZV5vStzcs.jpg"), Movie(id: 2, title: "Movie 2", voteAverage: 3.5, releaseDate: "2024-10-25", thumbnailPath: "/nohrh9aHNB1ehXmdtTZV5vStzcr.jpg")]
        sut.filteredMovies = [Movie(id: 1, title: "Movie 2", voteAverage: 5.5, releaseDate: "2024-10-15", thumbnailPath: "/nohrh9aHNB1ehXmdtTZV5vStzcs.jpg"), Movie(id: 2, title: "Movie 2", voteAverage: 3.5, releaseDate: "2024-10-25", thumbnailPath: "/nohrh9aHNB1ehXmdtTZV5vStzcr.jpg")]
        
        let initialMoviesCount = sut.movies.count
        
        sut.searchText = ""
        
        XCTAssertEqual(sut.filteredMovies, sut.movies)
        XCTAssertEqual(sut.filteredMovies.count, initialMoviesCount)
    }
    
    func testFilterMoviesSingleCharacterSearchText() async {
        sut = TMDBFactory.createMovieListViewModelMock()
        
        let movie1 = Movie(id: 1, title: "Avatar 2", voteAverage: 5.5, releaseDate: "2024-10-15", thumbnailPath: "/nohrh9aHNB1ehXmdtTZV5vStzcs.jpg")
        let movie2 = Movie(id: 2, title: "Inception", voteAverage: 3.5, releaseDate: "2024-10-25", thumbnailPath: "/nohrh9aHNB1ehXmdtTZV5vStzcr.jpg")
        
        sut.movies = [movie1, movie2]
        sut.filteredMovies = [movie1, movie2]

        await sut.filterMovies(by: "A")
       
        XCTAssertEqual(sut.filteredMovies, [movie1])
    }
    
    func testFetchNextMovieWhenThereAreTwoPages() async throws {
     
        let movie1 = Movie(id: 1, title: "Avatar 2", voteAverage: 5.5, releaseDate: "2024-10-15", thumbnailPath: "/nohrh9aHNB1ehXmdtTZV5vStzcs.jpg")
        let movie2 = Movie(id: 2, title: "Inception", voteAverage: 3.5, releaseDate: "2024-10-25", thumbnailPath: "/nohrh9aHNB1ehXmdtTZV5vStzcr.jpg")
        
        let movieServiceMock = MovieServiceMock(movieList: [movie1, movie2], totalPages: 2)
        
        let movieRepositoryMock = MovieRepository(movieService: movieServiceMock, persistentStoreManager: TMDBFactory.createPersistentStoreManagerMock(), networkMonitor: TMDBFactory.createNetworkMonitorMock())
        
        sut = MovieListViewModel(movieRepository: movieRepositoryMock)
        
        XCTAssertEqual(sut.viewState, .loading)
        
        _ = try await sut.fetchMovies()
        _ = try await sut.fetchNextMovie()
        
        XCTAssertEqual(sut.viewState, .finished)
        
        XCTAssertEqual(sut.currentPage, 2)
        
        XCTAssertEqual(sut.totalPages, 2)
    }
    
    func testFetchNextMovieWhenThereIsOnePage() async throws {
        
        // Arrange
        let movie1 = Movie(id: 1, title: "Avatar 2", voteAverage: 5.5, releaseDate: "2024-10-15", thumbnailPath: "/nohrh9aHNB1ehXmdtTZV5vStzcs.jpg")
        let movie2 = Movie(id: 2, title: "Inception", voteAverage: 3.5, releaseDate: "2024-10-25", thumbnailPath: "/nohrh9aHNB1ehXmdtTZV5vStzcr.jpg")
        
        let movieServiceMock = MovieServiceMock(movieList: [movie1, movie2], totalPages: 1)
        
        let movieRepositoryMock = MovieRepository(movieService: movieServiceMock, persistentStoreManager: TMDBFactory.createPersistentStoreManagerMock(), networkMonitor: TMDBFactory.createNetworkMonitorMock())
        
        sut = MovieListViewModel(movieRepository: movieRepositoryMock)
        
        XCTAssertEqual(sut.viewState, .loading)
        
        _ = try await sut.fetchMovies()
        
        _ = try await sut.fetchNextMovie()
        
        XCTAssertEqual(sut.viewState, .finished)
        
        XCTAssertEqual(sut.currentPage, 1)
        
        XCTAssertEqual(sut.totalPages, 1)
        
        XCTAssertEqual(sut.movies.count, 2)
        
        XCTAssertEqual(sut.filteredMovies.count, 2)
    }
    
    func testCachingWhenUserSegueToDetailScreenByTappingOnFirstMovieOnList() async throws {
        
        let movie1 = Movie(id: 1, title: "Avatar 2", voteAverage: 5.5, releaseDate: "2024-10-15", thumbnailPath: "/nohrh9aHNB1ehXmdtTZV5vStzcs.jpg")
        let movie2 = Movie(id: 2, title: "Inception", voteAverage: 3.5, releaseDate: "2024-10-25", thumbnailPath: "/nohrh9aHNB1ehXmdtTZV5vStzcr.jpg")
        
        let movieServiceMock = MovieServiceMock(movieList: [movie1, movie2], totalPages: 1)
        
        let persistentStoreManager = TMDBFactory.createPersistentStoreManagerMock()
        
        let movieRepositoryMock = MovieRepository(movieService: movieServiceMock, persistentStoreManager: persistentStoreManager, networkMonitor: TMDBFactory.createNetworkMonitorMock())
        
        sut = MovieListViewModel(movieRepository: movieRepositoryMock)
        
        XCTAssertEqual(sut.viewState, .loading)
        
        _ = try await sut.fetchMovies()
        
        await sut.saveMovieToPersistentStore(movie: sut.movies.first!)
        
        XCTAssertEqual(persistentStoreManager.getObject("Movies", [Movie].self), [movie1])
    }
    
    func testHasReachedEndShouldReturnTrue() async throws {

        let mockRepository = TMDBFactory.createMovieRepositoryMock()
        let viewModel = MovieListViewModel(movieRepository: mockRepository)
        
        let movie1 = Movie(id: 1, title: "Avatar 2", voteAverage: 5.5, releaseDate: "2024-10-15", thumbnailPath: "/nohrh9aHNB1ehXmdtTZV5vStzcs.jpg")
        let movie2 = Movie(id: 2, title: "Inception", voteAverage: 3.5, releaseDate: "2024-10-25", thumbnailPath: "/nohrh9aHNB1ehXmdtTZV5vStzcr.jpg")
        
        let testMovie = movie2
        viewModel.movies = [movie1, movie2]
        
        let result = await viewModel.hasReachedEnd(of: testMovie)
        
        XCTAssertTrue(result)
    }
    
    func testHasNotReachedEndShouldReturnFalse() async throws {

        let mockRepository = TMDBFactory.createMovieRepositoryMock()
        let viewModel = MovieListViewModel(movieRepository: mockRepository)
        
        let movie1 = Movie(id: 1, title: "Avatar 2", voteAverage: 5.5, releaseDate: "2024-10-15", thumbnailPath: "/nohrh9aHNB1ehXmdtTZV5vStzcs.jpg")
        let movie2 = Movie(id: 2, title: "Inception", voteAverage: 3.5, releaseDate: "2024-10-25", thumbnailPath: "/nohrh9aHNB1ehXmdtTZV5vStzcr.jpg")
        
        let testMovie = movie1
        viewModel.movies = [movie1, movie2]
        
        let result = await viewModel.hasReachedEnd(of: testMovie)
        
        XCTAssertFalse(result)
    }
    
    func testGetMovie() async throws {

        let mockRepository = TMDBFactory.createMovieRepositoryMock()
        let viewModel = MovieListViewModel(movieRepository: mockRepository)
        
        let movie1 = Movie(id: 1, title: "Avatar 2", voteAverage: 5.5, releaseDate: "2024-10-15", thumbnailPath: "/nohrh9aHNB1ehXmdtTZV5vStzcs.jpg")
        let movie2 = Movie(id: 2, title: "Inception", voteAverage: 3.5, releaseDate: "2024-10-25", thumbnailPath: "/nohrh9aHNB1ehXmdtTZV5vStzcr.jpg")
        
        viewModel.filteredMovies = [movie1, movie2]
        
        let index = 0
        
        let result = viewModel.getMovie(at: index)
        
        XCTAssertNotNil(result)
        XCTAssertEqual(result, movie1)
    }
}
