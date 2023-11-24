//
//  PersistentStoreManager+TheMovieDB.swift
//  TheMovieDB
//
//  Created by Mohammad Zulqurnain on 24/11/2023.
//

import Foundation

extension PersistentStoreManager: Equatable {
    static func == (lhs: PersistentStoreManager, rhs: PersistentStoreManager) -> Bool {
        lhs === rhs
    }
}
