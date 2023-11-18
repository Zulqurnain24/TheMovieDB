//
//  TheMovieDBApp.swift
//  TheMovieDB
//
//  Created by Mohammad Zulqurnain on 15/11/2023.
//

import SwiftUI

// MARK: - Constants

@main
struct TheMovieDBApp: App {
    var body: some Scene {
        WindowGroup {
            TMDBFactory.createMovieListView()
        }
    }
}
