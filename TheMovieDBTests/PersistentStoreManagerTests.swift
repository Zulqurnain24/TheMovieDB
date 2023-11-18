//
//  PersistentStoreManagerTests.swift
//  TheMovieDBTests
//
//  Created by Mohammad Zulqurnain on 18/11/2023.
//

import XCTest
@testable import TheMovieDB

// MARK: - PersistentStoreManagerTests

class PersistentStoreManagerTests: XCTestCase {
    
    var sut: PersistentStoreManagerProtocol?
    
    override func setUp() {
        super.setUp()
        sut = PersistentStoreManager.shared
    }
    
    override func tearDown() {
        sut = nil
        super.tearDown()
    }
    
    func testPersistentStoreManagerWhenObjectIsSavedAndRetrieved() async {
        
        let movies: [Movie] = [TMDBFactory.createMovieMock()]
        
        await sut?.setObject("Movies", value: movies)
        
        let retrievedValue = await sut?.getObject("Movies", [Movie].self)
        
        XCTAssertEqual(movies, retrievedValue, "Persistent store should save and retrieve correct value")
    }
    
    func testPersistentStoreManagerWhenStateIsCleared() async {
        
        let movies: [Movie] = [TMDBFactory.createMovieMock()]
        
        await sut?.setObject("Movies", value: movies)
        
        let retrievedValue = await sut?.getObject("Movies", [Movie].self)
        
        XCTAssertEqual(movies, retrievedValue, "Persistent store should save and retrieve correct value")
        
        await sut?.clearData("Movies")
        
        let updatedValue = await sut?.getObject("Movies", [Movie].self)
        
        XCTAssertEqual(updatedValue, nil, "Should clear the persistent store")
    }
}
