//
//  MoviesEndpointTest.swift
//  TheMovieDBTests
//
//  Created by Mohammad Zulqurnain on 18/11/2023.
//

import XCTest
@testable import TheMovieDB

// MARK: - MoviesEndpointTest

class MoviesEndpointTest: XCTestCase {
 
    func testPopularMoviesPath() {
        XCTAssertEqual(MoviesEndpoint.popularMovies(page: 1).path, "popular")
    }
    
    func testPopularMoviesURL() {
        XCTAssertEqual(MoviesEndpoint.popularMovies(page: 1).url, URL(string: "https://api.themoviedb.org/3/movie/popular?api_key=56a29f6d7010284157af93df3083d395&page=1"), "Endpoint should return expected url")
    }
    
    func testPopularMoviesQueryItems() {
        XCTAssertEqual(MoviesEndpoint.popularMovies(page: 1).queryItems, [URLQueryItem(name: "api_key", value: "56a29f6d7010284157af93df3083d395"), URLQueryItem(name: "page", value: "\(1)")], "Endpoint should return expected QueryItems")
    }
    
    func testPopularMoviesBaseURL() {
        XCTAssertEqual(MoviesEndpoint.popularMovies(page: 1).baseUrl, "https://api.themoviedb.org/3/movie", "Endpoint should return correct baseURL")
    }
    
    func testMovieDetailsPath() {
        XCTAssertEqual(MoviesEndpoint.movieDetails(id: 1).path, "1", "Endpoint should reflect expected path")
    }
    
    func testMovieDetailsURL() {
        XCTAssertEqual(MoviesEndpoint.movieDetails(id: 1).url, URL(string: "https://api.themoviedb.org/3/movie/1?api_key=56a29f6d7010284157af93df3083d395"), "Endpoint should return expected url")
    }
    
    func testMovieDetailsQueryItems() {
        XCTAssertEqual(MoviesEndpoint.movieDetails(id: 1).queryItems, [URLQueryItem(name: "api_key", value: "56a29f6d7010284157af93df3083d395")], "Endpoint should return expected QueryItems")
    }
    
    func testMovieDetailsBaseURL() {
        XCTAssertEqual(MoviesEndpoint.movieDetails(id: 1).baseUrl, "https://api.themoviedb.org/3/movie", "Endpoint should return expected baseurl")
    }
}
