//
//  JSONDecoder+TheMovieDB.swift
//  TheMovieDB
//
//  Created by Mohammad Zulqurnain on 24/11/2023.
//

import Foundation

extension JSONDecoder: Equatable {
    public static func == (lhs: JSONDecoder, rhs: JSONDecoder) -> Bool {
        lhs.userInfo.keys == rhs.userInfo.keys
    }
}
