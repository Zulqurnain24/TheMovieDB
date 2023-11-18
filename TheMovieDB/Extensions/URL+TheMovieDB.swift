//
//  URL+TheMovieDB.swift
//  TheMovieDB
//
//  Created by Mohammad Zulqurnain on 17/11/2023.
//

import UIKit

extension URL {
    func verifyUrl() -> Bool {
        if let urlString = self.absoluteString as? String {
            if let url = NSURL(string: urlString) {
                return UIApplication.shared.canOpenURL(url as URL)
            }
        }
        return false
    }
}
