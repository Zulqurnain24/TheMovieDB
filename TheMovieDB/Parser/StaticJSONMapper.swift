//
//  StaticJSONMapper.swift
//  TheMovieDB
//
//  Created by Mohammad Zulqurnain on 17/11/2023.
//

import Foundation

// MARK: - StaticJSONMapper

struct StaticJSONMapper {

    static func decode<T: Decodable>(file: String, type: T.Type) throws -> T {

        guard !file.isEmpty,
              let path = Bundle.main.path(forResource: file, ofType: "json"),
              let data = FileManager.default.contents(atPath: path) else {
            throw MappingError.failedToGetContents
        }

        let decoder = JSONDecoder()
        return try decoder.decode(T.self, from: data)
    }
}

extension StaticJSONMapper {
    enum MappingError: Error {
        case failedToGetContents
    }
}
