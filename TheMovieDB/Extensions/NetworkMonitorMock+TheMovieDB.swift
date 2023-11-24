//
//  NetworkMonitorMock+TheMovieDB.swift
//  TheMovieDB
//
//  Created by Mohammad Zulqurnain on 24/11/2023.
//

import Foundation

extension NetworkMonitorMock: Equatable {
    static func == (lhs: NetworkMonitorMock, rhs: NetworkMonitorMock) -> Bool {
        lhs.isConnected ==  rhs.isConnected
        &&
        lhs.isMonitoring ==  rhs.isMonitoring
    }
}
