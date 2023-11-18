//
//  NetworkingManagerMock.swift
//  TheMovieDB
//
//  Created by Mohammad Zulqurnain on 17/11/2023.
//

import Foundation

// MARK: - NetworkingManagerMock

final class NetworkingManagerMock: NetworkingManagerProtocol {
    
    var jsonFileName: String?
    var imageData: Data?
    
    static let shared = NetworkingManagerMock()
    
    private init() {}
    
    func request<T>(url: URL, session: URLSession, type: T.Type) async throws -> T where T : Decodable, T : Encodable {
        do {
            if let jsonFileName = jsonFileName {
                do {
                    let res = try StaticJSONMapper.decode(file: jsonFileName, type: T.self)
                    return res
                } catch {
                    throw MovieService.NetworkError.decodingError
                }
            } else if let imageData = imageData {
                return imageData as! T
            }
        } catch {
            throw error
        }
        
        throw MovieService.NetworkError.decodingError
    }
    
}

extension NetworkingManagerMock {
    enum NetworkingError: LocalizedError {
        case invalidUrl
        case invalidStatusCode(statusCode: Int)
    }
}

private extension NetworkingManagerMock {
    func buildRequest(from url: URL) -> URLRequest {
        
        var request = URLRequest(url: url)
        
        request.httpMethod = Constants.getRequestType
        
        return request
    }
}
