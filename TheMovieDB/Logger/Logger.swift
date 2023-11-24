//
//  Logger.swift
//  TheMovieDB
//
//  Created by Mohammad Zulqurnain on 15/11/2023.
//

import Foundation

protocol Logging {
    static func logError<T>(_ type: T.Type, _ error: Error)
    static func logInfo<T>(_ type: T.Type, _ info: String)
}

// MARK: - Logger

struct Logger: Logging {
    static func logError<T>(_ type: T.Type, _ error: Error) {
#if DEBUG
        print("\(Constants.logStart) \n \(Constants.logErrorPrefix) \(type.self)\(Constants.errorlabel) \(error) \n \(Constants.timestampLabel) : \(Date()) \n \(Constants.logEnd) \n ")
#endif
    }
    
    static func logInfo<T>(_ type: T.Type, _ info: String) {
#if DEBUG
        print("\(Constants.logStart) \n \(Constants.logInfoPrefix) \(type.self) Info: \(info) \n \(Constants.timestampLabel) : \(Date()) \n \(Constants.logEnd) ")
#endif
    }
}
