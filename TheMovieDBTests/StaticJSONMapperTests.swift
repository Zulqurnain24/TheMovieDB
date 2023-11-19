//
//  StaticJSONMapperTests.swift
//  TheMovieDBTests
//
//  Created by Mohammad Zulqurnain on 20/11/2023.
//

import XCTest
@testable import TheMovieDB

// MARK: - StaticJSONMapperTests

class StaticJSONMapperTests: XCTestCase {

    func testJSONParsing() {
        let movieResponse = try!StaticJSONMapper.decode(file: "MovieData", type: MovieResponse.self)

        XCTAssertEqual(movieResponse.movies.first, Movie(id: 872585, title: "Oppenheimer", voteAverage: 8.223, releaseDate: "2023-07-19", thumbnailPath: "/fm6KqXpk3M2HVveHwCrBSSBaO0V.jpg"))
    
        XCTAssertEqual(movieResponse.movies.count, 20)
        
        XCTAssertEqual(movieResponse.totalPages, 41367)
    }
}
