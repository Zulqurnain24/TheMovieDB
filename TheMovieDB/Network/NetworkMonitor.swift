//
//  NetworkMonitor.swift
//  TheMovieDB
//
//  Created by Mohammad Zulqurnain on 16/11/2023.
//

import Foundation
import Network

protocol NetworkMonitorProtocol {
    var isConnected: Bool { get set }
    var isMonitoring: Bool { get set }
    func startMonitoring()
    func stopMonitoring()
}

class NetworkMonitor: NetworkMonitorProtocol {
    private let monitor: NWPathMonitor
    
    var isMonitoring = false
    
    @Published var isConnected = true
    
    init(monitor: NWPathMonitor = NWPathMonitor()) {
        self.monitor = monitor
        
        startMonitoring()
    }
    
    deinit {
        stopMonitoring()
    }
    
    func startMonitoring() {
        guard !isMonitoring else { return }
        
        monitor.pathUpdateHandler = { [weak self] path in
            DispatchQueue.main.async {
                self?.isConnected = path.status == .satisfied
            }
        }
        
        let queue = DispatchQueue(label: "NetworkMonitor")
        monitor.start(queue: queue)
        isMonitoring = true
    }
    
    func stopMonitoring() {
        monitor.cancel()
        isMonitoring = false
    }
}
