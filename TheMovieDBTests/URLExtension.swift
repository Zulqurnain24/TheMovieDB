//
//  URLExtension.swift
//  TheMovieDBTests
//
//  Created by Mohammad Zulqurnain on 18/11/2023.
//

import XCTest
@testable import TheMovieDB

// MARK: - URLExtension

class URLExtension: XCTestCase {
 
    func testValidURL() {
        XCTAssertTrue( URL(string: "https://www.linkedin.com/in/muhammad-zulqurnain-2448414b/")!.verifyUrl(), "Valid URL should return true")
    }
    
    func testInValidURL() {
        XCTAssertFalse( URL(string: ".linkedin.com/in/muhammad-zulqurnain-2448414b/")!.verifyUrl(), "Valid URL should return true")
    }
}
