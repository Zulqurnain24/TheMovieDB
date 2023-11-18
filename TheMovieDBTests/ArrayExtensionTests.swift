//
//  Array+TheMovieDBTests.swift
//  TheMovieDBTests
//
//  Created by Mohammad Zulqurnain on 18/11/2023.
//

import XCTest
@testable import TheMovieDB

// MARK: - ArrayExtensionTests

class ArrayExtensionTests: XCTestCase {
 
    func testUniqueElement() {
        let repeatingNumbersArray = [1,1,2,4,8]
        XCTAssertEqual(repeatingNumbersArray.unique(), [1,2,4,8], "Should get the unique iterator elements")
    }
}
