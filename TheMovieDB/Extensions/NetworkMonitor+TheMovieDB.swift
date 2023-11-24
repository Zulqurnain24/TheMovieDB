//
//  NetworkMonitor+TheMovieDB.swift
//  TheMovieDB
//
//  Created by Mohammad Zulqurnain on 24/11/2023.
//

import Foundation

extension NetworkMonitor: Equatable {
    static func == (lhs: NetworkMonitor, rhs: NetworkMonitor) -> Bool {
        lhs.isMonitoring == rhs.isMonitoring
        &&
        lhs.isConnected ==  rhs.isConnected
    }
}
