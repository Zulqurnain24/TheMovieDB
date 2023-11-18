//
//  NetworkMonitorTests.swift
//  TheMovieDBTests
//
//  Created by Mohammad Zulqurnain on 18/11/2023.
//

import XCTest
@testable import TheMovieDB

// MARK: - NetworkMonitorTests

class NetworkMonitorTests: XCTestCase {
    
    var sut: NetworkMonitor?
    
    override func setUp() {
        super.setUp()
        sut = NetworkMonitor()
    }
    
    override func tearDown() {
        sut = nil
        super.tearDown()
    }
    
    func testWhenStartMonitoringIsCalledThenIsConnectedIsTrue() {
        sut?.startMonitoring()
        XCTAssertTrue(sut?.isMonitoring ?? false, "After startMonitoring() is called should return correct isMonitoring status")
    }
    
    func testWhenStopMonitoringIsCalledThenIsConnectedIsTrue() {
        sut?.stopMonitoring()
        XCTAssertFalse(sut?.isMonitoring ?? false, "After stopMonitoring() is called should return correct isMonitoring status")
    }
}
