//
//  URLSession+TheMovieDB.swift
//  TheMovieDB
//
//  Created by Mohammad Zulqurnain on 16/11/2023.
//

import Foundation

protocol NetworkingManagerProtocol {
    
    func request<T: Codable>(url: URL, session: URLSession, type: T.Type) async throws -> T
}

// MARK: - NetworkingManager

final class NetworkingManager: NetworkingManagerProtocol {
    
    let decoder: JSONDecoder
    
    static let shared = NetworkingManager()
    
    private init(decoder: JSONDecoder = TMDBFactory.createDecoder()) {
        self.decoder = decoder
    }
   
    func request<T: Codable>(url: URL, session: URLSession = .shared, type: T.Type) async throws -> T {
        
        guard url.verifyUrl() else {
            throw NetworkingError.invalidUrl
        }
        
        let request = buildRequest(from: url)
        
        do {
            let (data, response) = try await session.data(for: request)
            
            guard let response = response as? HTTPURLResponse,
                  Constants.validStatusCodeRange ~= response.statusCode else {
                let statusCode = (response as? HTTPURLResponse)?.statusCode
                throw NetworkingError.invalidStatusCode(statusCode: statusCode ?? 0)
            }
        
            let res = try decoder.decode(T.self, from: data)
            
            Logger.logInfo(Self.self, "successfully decoded response \(res)")
            
            return res
        } catch {
            throw NetworkingError.decodingError(description: "\(error)")
        }
    }
}

extension NetworkingManager {
    enum NetworkingError: LocalizedError {
        case invalidUrl
        case invalidStatusCode(statusCode: Int)
        case decodingError(description: String)
    }
}

extension NetworkingManager.NetworkingError: Equatable {
    
    static func == (lhs: NetworkingManager.NetworkingError, rhs: NetworkingManager.NetworkingError) -> Bool {
        switch(lhs, rhs) {
        case (.invalidUrl, .invalidUrl):
            return true
        case (.invalidStatusCode(let lhsType), .invalidStatusCode(let rhsType)):
            return lhsType == rhsType
        default:
            return false
        }
    }
}

extension NetworkingManager.NetworkingError {
    
    var errorDescription: String? {
        switch self {
        case .invalidUrl:
            return Constants.networkInvaidErrorDescription
        case .invalidStatusCode:
            return Constants.networkInvalidStatusCode
        case .decodingError(let description):
            return "\(Constants.decodingErrorLabel) \(description)"
        }
    }
}

private extension NetworkingManager {
    func buildRequest(from url: URL) -> URLRequest {
        
        var request = URLRequest(url: url)
        
        request.httpMethod = Constants.getRequestType
        
        return request
    }
}

