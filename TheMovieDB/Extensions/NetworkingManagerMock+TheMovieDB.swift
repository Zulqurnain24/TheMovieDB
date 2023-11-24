//
//  NetworkingManagerMock+TheMovieDB.swift
//  TheMovieDB
//
//  Created by Mohammad Zulqurnain on 24/11/2023.
//

extension NetworkingManagerMock: Equatable {
    static func == (lhs: NetworkingManagerMock, rhs: NetworkingManagerMock) -> Bool {
        lhs === rhs
    }
}
