//
//  ImagesEndpointTest.swift
//  TheMovieDBTests
//
//  Created by Mohammad Zulqurnain on 18/11/2023.
//

import XCTest
@testable import TheMovieDB

class ImagesEndpointTest: XCTestCase {
 
    func testGetThumbnailName() {
        XCTAssertEqual(ImagesEndpoint.getThumbnail("/8Gxv8gSFCU0XGDykEGv7zR1n2ua.jpg").name, "/8Gxv8gSFCU0XGDykEGv7zR1n2ua.jpg")
    }
    
    func testGetThumbnailUrl() {
        XCTAssertEqual(ImagesEndpoint.getThumbnail("/8Gxv8gSFCU0XGDykEGv7zR1n2ua.jpg").url, URL(string: "https://image.tmdb.org/t/p/w200/8Gxv8gSFCU0XGDykEGv7zR1n2ua.jpg"))
    }
    
    func testGetThumbnailBaseUrl() {
        XCTAssertEqual(ImagesEndpoint.getThumbnail("/8Gxv8gSFCU0XGDykEGv7zR1n2ua.jpg").baseUrl, "https://image.tmdb.org/t/p")
    }
    
    func testGetThumbnailDimension() {
        XCTAssertEqual(ImagesEndpoint.getThumbnail("/8Gxv8gSFCU0XGDykEGv7zR1n2ua.jpg").dimension, "w200")
    }
    
    func testGetPosterName() {
        XCTAssertEqual(ImagesEndpoint.getPosterImage("/8Gxv8gSFCU0XGDykEGv7zR1n2ua.jpg").name, "/8Gxv8gSFCU0XGDykEGv7zR1n2ua.jpg")
    }
    
    func testGetPosterUrl() {
        XCTAssertEqual(ImagesEndpoint.getPosterImage("/8Gxv8gSFCU0XGDykEGv7zR1n2ua.jpg").url, URL(string: "https://image.tmdb.org/t/p/w300/8Gxv8gSFCU0XGDykEGv7zR1n2ua.jpg"))
    }
    
    func testGetPosterBaseUrl() {
        XCTAssertEqual(ImagesEndpoint.getPosterImage("/8Gxv8gSFCU0XGDykEGv7zR1n2ua.jpg").baseUrl, "https://image.tmdb.org/t/p")
    }
    
    func testGetPosterDimension() {
        XCTAssertEqual(ImagesEndpoint.getPosterImage("/8Gxv8gSFCU0XGDykEGv7zR1n2ua.jpg").dimension, "w300")
    }
}
