//
//  NetworkMonitorMock.swift
//  TheMovieDB
//
//  Created by Mohammad Zulqurnain on 17/11/2023.
//

import Foundation

// MARK: - NetworkMonitorMock

class NetworkMonitorMock: NetworkMonitorProtocol {

    @Published var isConnected = false
    var isMonitoring: Bool

    init(isConnected: Bool, isMonitoring: Bool) {
        self.isConnected = isConnected
        self.isMonitoring = isMonitoring

        startMonitoring()
    }

    deinit {
        stopMonitoring()
    }

    func startMonitoring() {
        isMonitoring = true
    }

    func stopMonitoring() {
        isMonitoring = false
    }
}
