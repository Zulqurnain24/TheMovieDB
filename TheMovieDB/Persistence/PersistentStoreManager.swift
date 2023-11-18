//
//  PersistentStore.swift
//  TheMovieDB
//
//  Created by Mohammad Zulqurnain on 15/11/2023.
//

import Foundation

protocol PersistentStoreManagerProtocol {
    func setObject<T: Codable>(_ key: String, value: T) async
    func getObject<T: Codable>(_ key: String, _ type: T.Type) async -> T?
    func clearData(_ key: String) async
}

// MARK: - PersistentStoreManager

class PersistentStoreManager: PersistentStoreManagerProtocol {
    
    enum PersistentStore: Error {
        case decodingError
    }
    
    static let shared = PersistentStoreManager()
    
    func setObject<T: Codable>(_ key: String, value: T) {
        let updatedkey = key
        let encoder = JSONEncoder()
        
        guard let encoded = try? encoder.encode(value) else { 
            Logger.logError(Self.self, PersistentStore.decodingError)
            return
        }
        
        UserDefaults.standard.set(encoded, forKey: updatedkey)
        
        Logger.logInfo(Self.self, "setObject<T: Codable>(_ key: \(key), value: \(value)")
    }
    
    func getObject<T: Codable>(_ key: String, _ type: T.Type) -> T? {
        let updatedkey = key
        let decoder = JSONDecoder()
        var value: T?
        if let data = UserDefaults.standard.data(forKey: updatedkey) {
            guard let decodedValue = try? decoder.decode(type, from: data) else {
                
                Logger.logInfo(Self.self, "Unable to decode the value - getObject<T: Codable>(_ key: \(key), _ type: \(type)")
                
                return nil
            }
            value = decodedValue
        }
        
        Logger.logInfo(Self.self, "getObject<T: Codable>(_ key: \(key), _ type: \(type)")
        
        return value
    }
    
    func clearData(_ key: String) {
        let updatedkey = key
        UserDefaults.standard.removeObject(forKey: updatedkey)
        UserDefaults.standard.synchronize()
        
        Logger.logInfo(Self.self, "clear data for key \(key)")
    }
}
