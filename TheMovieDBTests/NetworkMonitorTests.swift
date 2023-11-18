//
//  NetworkMonitorTests.swift
//  TheMovieDBTests
//
//  Created by Mohammad Zulqurnain on 18/11/2023.
//

import XCTest
@testable import TheMovieDB

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
        XCTAssertTrue(sut?.isMonitoring ?? false)
    }
    
    func testWhenStopMonitoringIsCalledThenIsConnectedIsTrue() {
        sut?.stopMonitoring()
        XCTAssertFalse(sut?.isMonitoring ?? false)
    }
}
