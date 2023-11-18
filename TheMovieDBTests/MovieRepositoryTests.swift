//
//  MovieRepositoryTests.swift
//  TheMovieDBTests
//
//  Created by Mohammad Zulqurnain on 18/11/2023.
//

import XCTest
@testable import TheMovieDB

// MARK: - MovieRepositoryTests

class MovieRepositoryTests: XCTestCase {
    
    var sut: MovieRepository?

    override func tearDown() {
        sut = nil
        super.tearDown()
    }
    
    func testGetPopularMoviesFromInternet() async {
        do {
            let networkMonitorMock = NetworkMonitorMock(isConnected: true, isMonitoring: true)
            let movieServiceMock = MovieServiceMock(movieList: [TMDBFactory.createMovieMock()], filterList: [TMDBFactory.createMovieMock()], totalPages:1)
          
            sut = MovieRepository(movieService: movieServiceMock, persistentStoreManager: TMDBFactory.createPersistentStoreManagerMock(), networkMonitor: networkMonitorMock)
            
            networkMonitorMock.isConnected = true
            
            let movieResponse = try await sut?.getPopularMovies(page: 1)
            
            XCTAssertEqual(movieResponse, MovieResponse(movies: [TheMovieDB.Movie(id: 123, title: "Mocked Title", voteAverage: 5.5, releaseDate: "2021-10-13", thumbnailPath: "/nohrh9aHNB1ehXmdtTZV5vStzcs.jpg")], totalPages: 1), "Should return expected movieResponse")
        } catch {
            Logger.logError(Self.self, error)
        }
    }
    
    func testGetMovieDetailsFromInternet() async {
        do {
            let networkMonitorMock = NetworkMonitorMock(isConnected: true, isMonitoring: true)
            let movieServiceMock = MovieServiceMock(movieDetails: TMDBFactory.createMovieDetailsMock())
          
            sut = MovieRepository(movieService: movieServiceMock, persistentStoreManager: TMDBFactory.createPersistentStoreManagerMock(), networkMonitor: networkMonitorMock)
            
            networkMonitorMock.isConnected = true
            
            let movieDetails = try await sut?.getMovieDetails(for: 872585)
            
            XCTAssertEqual(movieDetails, MovieDetails(id: 1, title: "Mocked Title", overview: "Mocked Overview", posterPath: Optional("/4m1Au3YkjqsxF8iwQy0fPYSxE0h.jpg"), voteAverage: 7.0, homepage: "https://www.oppenheimermovie.com/"), "Should return expected movie detail")
        } catch {
            Logger.logError(Self.self, error)
        }
    }
    
    func testGetPopularMoviesFromPersistentStore() async {
        do {
            let networkMonitorMock = NetworkMonitorMock(isConnected: true, isMonitoring: true)
            
            let persistentStoreManagerMock = TMDBFactory.createPersistentStoreManagerMock()
            
            sut = MovieRepository(movieService: TMDBFactory.createMovieServiceMock(), persistentStoreManager: persistentStoreManagerMock, networkMonitor: networkMonitorMock)
            
            await sut?.saveMovieToPersistentStore(movie: TMDBFactory.createMovieMock())
            
            networkMonitorMock.isConnected = false
            
            _ = try await sut?.getPopularMovies(page: 1)
            
            XCTAssertEqual(persistentStoreManagerMock.getObject("Movies", [Movie].self), [TheMovieDB.Movie(id: 123, title: "Mocked Title", voteAverage: 5.5, releaseDate: "2021-10-13", thumbnailPath: "/nohrh9aHNB1ehXmdtTZV5vStzcs.jpg")], "Should retrieve expected movieResponse from persistent store")
            
        } catch {
            XCTFail("Should receive correct response from the persistentStoreManager")
        }
    }
    
    func testGetMovieDetailsFromPersistentStore() async {
        do {
            let networkMonitorMock = NetworkMonitorMock(isConnected: true, isMonitoring: true)
            
            let persistentStoreManagerMock = TMDBFactory.createPersistentStoreManagerMock()
            
            let movieServiceMock = MovieServiceMock(movieDetails: TMDBFactory.createMovieDetailsMock())
            
            sut = MovieRepository(movieService: movieServiceMock, persistentStoreManager: persistentStoreManagerMock, networkMonitor: networkMonitorMock)
            
            networkMonitorMock.isConnected = true
            
            let movieDetailsFromNetworkmanager = try await sut?.getMovieDetails(for: 872585)
            
            networkMonitorMock.isConnected = false
            
            let movieDetailsFromPersistentStore = try await sut?.getMovieDetails(for: 872585)
            
            XCTAssertEqual(movieDetailsFromNetworkmanager, movieDetailsFromPersistentStore, "Should retrieve expected movie details from the persistent store")
        } catch {
            Logger.logError(Self.self, error)
        }
    }
}
