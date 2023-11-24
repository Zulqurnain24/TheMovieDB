//
//  PersistentStoreManagerMock+TheMovieDB.swift
//  TheMovieDB
//
//  Created by Mohammad Zulqurnain on 24/11/2023.
//

import Foundation

extension PersistentStoreManagerMock: Equatable {
    static func == (lhs: PersistentStoreManagerMock, rhs: PersistentStoreManagerMock) -> Bool {
        lhs === rhs
    }
}
