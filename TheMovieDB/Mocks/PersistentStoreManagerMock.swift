//
//  PersistentStoreManagerMock.swift
//  TheMovieDB
//
//  Created by Mohammad Zulqurnain on 17/11/2023.
//

import Foundation

class PersistentStoreManagerMock: PersistentStoreManagerProtocol {
    
    enum PersistentStore: Error {
        case decodingError
    }
    
    static let shared = PersistentStoreManagerMock()
    
    var persistenceStoreMock = [String : Any]()
    
    func setObject<T: Codable>(_ key: String, value: T) {
        persistenceStoreMock[key] = value
    }
    
    func getObject<T: Codable>(_ key: String, _ type: T.Type) -> T? {
        return  persistenceStoreMock[key] as? T
    }
    
    func clearData(_ key: String) {
        persistenceStoreMock.removeAll()
    }
}
