//
//  ImageLoader+TheMovieDB.swift
//  TheMovieDB
//
//  Created by Mohammad Zulqurnain on 24/11/2023.
//

import Foundation

extension ImageLoader: Equatable {
    static func == (lhs: ImageLoader, rhs: ImageLoader) -> Bool {
        lhs.image == rhs.image
    }
}
