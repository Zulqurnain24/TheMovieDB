//
//  URL+TheMovieDB.swift
//  TheMovieDB
//
//  Created by Mohammad Zulqurnain on 17/11/2023.
//

import UIKit

// MARK: - URL+TheMovieDB

extension URL {
    func verifyUrl() -> Bool {
        if let url = NSURL(string: self.absoluteString) {
            return UIApplication.shared.canOpenURL(url as URL)
        }
        return false
    }
}
