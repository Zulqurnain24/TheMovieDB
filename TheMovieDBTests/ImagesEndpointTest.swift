//
//  ImagesEndpointTest.swift
//  TheMovieDBTests
//
//  Created by Mohammad Zulqurnain on 18/11/2023.
//

import XCTest
@testable import TheMovieDB

// MARK: - ImagesEndpointTest

class ImagesEndpointTest: XCTestCase {
 
    func testGetThumbnailName() {
        XCTAssertEqual(ImagesEndpoint.getThumbnail("/8Gxv8gSFCU0XGDykEGv7zR1n2ua.jpg").name, "/8Gxv8gSFCU0XGDykEGv7zR1n2ua.jpg", "Endpoint should return correct name")
    }
    
    func testGetThumbnailUrl() {
        XCTAssertEqual(ImagesEndpoint.getThumbnail("/8Gxv8gSFCU0XGDykEGv7zR1n2ua.jpg").url, URL(string: "https://image.tmdb.org/t/p/w200/8Gxv8gSFCU0XGDykEGv7zR1n2ua.jpg"), "Endpoint should return correct url")
    }
    
    func testGetThumbnailBaseUrl() {
        XCTAssertEqual(ImagesEndpoint.getThumbnail("/8Gxv8gSFCU0XGDykEGv7zR1n2ua.jpg").baseUrl, "https://image.tmdb.org/t/p", "Endpoint should return correct base url")
    }
    
    func testGetThumbnailDimension() {
        XCTAssertEqual(ImagesEndpoint.getThumbnail("/8Gxv8gSFCU0XGDykEGv7zR1n2ua.jpg").dimension, "w200", "Endpoint should return correct image dimension")
    }
    
    func testGetPosterName() {
        XCTAssertEqual(ImagesEndpoint.getPosterImage("/8Gxv8gSFCU0XGDykEGv7zR1n2ua.jpg").name, "/8Gxv8gSFCU0XGDykEGv7zR1n2ua.jpg", "Endpoint should return posterName")
    }
    
    func testGetPosterUrl() {
        XCTAssertEqual(ImagesEndpoint.getPosterImage("/8Gxv8gSFCU0XGDykEGv7zR1n2ua.jpg").url, URL(string: "https://image.tmdb.org/t/p/w300/8Gxv8gSFCU0XGDykEGv7zR1n2ua.jpg"), "Endpoint should return the correct url")
    }
    
    func testGetPosterBaseUrl() {
        XCTAssertEqual(ImagesEndpoint.getPosterImage("/8Gxv8gSFCU0XGDykEGv7zR1n2ua.jpg").baseUrl, "https://image.tmdb.org/t/p", "Endpoint should return the correct base url")
    }
    
    func testGetPosterDimension() {
        XCTAssertEqual(ImagesEndpoint.getPosterImage("/8Gxv8gSFCU0XGDykEGv7zR1n2ua.jpg").dimension, "w300", "Endpoint should return the correct dimension")
    }
}
