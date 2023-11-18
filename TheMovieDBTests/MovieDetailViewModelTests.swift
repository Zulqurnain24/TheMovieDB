//
//  MovieDetailsTests.swift
//  TheMovieDBTests
//
//  Created by Mohammad Zulqurnain on 18/11/2023.
//

import XCTest
@testable import TheMovieDB

class MovieDetailViewModelTests: XCTestCase {
    
    var sut: MovieDetailViewModel?
  
    override func tearDown() {
        sut = nil
        super.tearDown()
    }
    
    func testFetchMovieDetailsFromInternet() async {
        let movieServiceMock = MovieServiceMock(movieDetails: TMDBFactory.createMovieDetailsMock())
        
        let networkMonitorMock = NetworkMonitorMock(isConnected: true, isMonitoring: true)
        
        networkMonitorMock.isConnected = true
        
        let movieRepositoryMock = MovieRepository(movieService: movieServiceMock, persistentStoreManager: TMDBFactory.createPersistentStoreManagerMock(), networkMonitor: networkMonitorMock)
        
        sut = MovieDetailViewModel(movie: TMDBFactory.createMovieMock(), movieRepository: movieRepositoryMock)
        
        await sut?.fetchMovieDetails()
        
        XCTAssertEqual(sut?.movieDetails, MovieDetails(id: 1, title: "Mocked Title", overview: "Mocked Overview", posterPath: Optional("/4m1Au3YkjqsxF8iwQy0fPYSxE0h.jpg"), voteAverage: 7.0, homepage: "https://www.oppenheimermovie.com/"))
    }
    
    func testFetchMovieDetailsFromPersistentStore() async {
        let movieServiceMock = MovieServiceMock(movieDetails: TMDBFactory.createMovieDetailsMock())
        
        let networkMonitorMock = NetworkMonitorMock(isConnected: true, isMonitoring: true)
        
        networkMonitorMock.isConnected = true
        
        let movieRepositoryMock = MovieRepository(movieService: movieServiceMock, persistentStoreManager: TMDBFactory.createPersistentStoreManagerMock(), networkMonitor: networkMonitorMock)
        
        sut = MovieDetailViewModel(movie: TMDBFactory.createMovieMock(), movieRepository: movieRepositoryMock)
        
        await sut?.fetchMovieDetails()
        
        let movieDetailsFromInternet = sut?.movieDetails
        
        XCTAssertEqual(movieDetailsFromInternet, MovieDetails(id: 1, title: "Mocked Title", overview: "Mocked Overview", posterPath: Optional("/4m1Au3YkjqsxF8iwQy0fPYSxE0h.jpg"), voteAverage: 7.0, homepage: "https://www.oppenheimermovie.com/"))
        
        networkMonitorMock.isConnected = false
        
        await sut?.fetchMovieDetails()
        
        let movieDetailsFromPersistentStore = sut?.movieDetails
        
        XCTAssertEqual(movieDetailsFromPersistentStore, movieDetailsFromInternet)
    }
}
