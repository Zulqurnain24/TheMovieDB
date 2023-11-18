//
//  NetworkingManagerTests.swift
//  TheMovieDBTests
//
//  Created by Mohammad Zulqurnain on 17/11/2023.
//

import XCTest
@testable import TheMovieDB

class NetworkingManagerTests: XCTestCase {
    
    private var session: URLSession!
    private var url: URL!
    
    override func setUp() {
        url = URL(string: "https://api.themoviedb.org/3/movie/popular?api_key=56a29f6d7010284157af93df3083d395")
        
        let configuration = URLSessionConfiguration.ephemeral
        configuration.protocolClasses = [MockURLSessionProtocol.self]
        session = URLSession(configuration: configuration)
    }
    
    override func tearDown() {
        session = nil
        url = nil
    }
    
    func testNetworkingManagerWhenStatusCodeIsValid() async throws {
        
        guard let path = Bundle.main.path(forResource: "MovieData", ofType: "json"),
              let data = FileManager.default.contents(atPath: path) else {
            XCTFail("Failed to get the static users file")
            return
        }
        
        MockURLSessionProtocol.loadingHandler = {
            let response = HTTPURLResponse(url: self.url,
                                           statusCode: 200,
                                           httpVersion: nil,
                                           headerFields: nil)
            return (response!, data)
        }
        
        let res = try await NetworkingManager.shared.request(url: self.url, type: MovieResponse.self)
        
        let movieData = try StaticJSONMapper.decode(file: "MovieData", type: MovieResponse.self)

        XCTAssertEqual(res, movieData, "The returned response should be decoded properly")
    }
 
    func testNetworkingManagerWhenStatusCodeIsNotValid() async {
        
        let invalidStatusCode = 400
        
        MockURLSessionProtocol.loadingHandler = {
            let response = HTTPURLResponse(url: self.url,
                                           statusCode: invalidStatusCode,
                                           httpVersion: nil,
                                           headerFields: nil)
            return (response!, nil)
        }
        
        do {
            let res = try await NetworkingManager.shared.request(url: self.url, type: MovieResponse.self)
        } catch {
            
            guard let networkingError = error as? NetworkingManager.NetworkingError else {
                XCTFail("Got the wrong type of error, expecting NetworkingManager NetworkingError")
                return
            }
            
            XCTAssertEqual(networkingError,
                           NetworkingManager.NetworkingError.invalidStatusCode(statusCode: invalidStatusCode),
                           "Error should be a networking error which throws an invalid status code")
            
        }
    }
    
    func testNetworkingManagerWhenStatusCodeIsValidButUrlIsInvalid() async {
        
        let invalidStatusCode = 200
        
        self.url = URL(string: "wrongurl")
        
        MockURLSessionProtocol.loadingHandler = {
            let response = HTTPURLResponse(url: self.url,
                                           statusCode: invalidStatusCode,
                                           httpVersion: nil,
                                           headerFields: nil)
            return (response!, nil)
        }
        
        do {
            let res = try await NetworkingManager.shared.request(url: self.url, type: MovieResponse.self)
        } catch {
            
            guard let networkingError = error as? NetworkingManager.NetworkingError else {
                XCTFail("Got the wrong type of error, expecting NetworkingManager NetworkingError")
                return
            }
            
            XCTAssertEqual(networkingError,
                           NetworkingManager.NetworkingError.invalidUrl,
                           "Error should be a networking error which throws an invalid status code")
            
        }
    }
    
    func testNetworkingManagerWhenStatusCodeIsValidButThereIsUnexpectedJSONResponse() async throws {
        
        guard let path = Bundle.main.path(forResource: "MovieDataIncorrectJson", ofType: "json"),
              let data = FileManager.default.contents(atPath: path) else {
            XCTFail("Failed to get the static users file")
            return
        }
        
        MockURLSessionProtocol.loadingHandler = {
            let response = HTTPURLResponse(url: self.url,
                                           statusCode: 200,
                                           httpVersion: nil,
                                           headerFields: nil)
            return (response!, nil)
        }
        
        do {
            let res = try await NetworkingManager.shared.request(url: self.url, type: MovieResponse.self)
        } catch {
            
            guard let networkingError = error as? NetworkingManager.NetworkingError else {
                XCTFail("Got the wrong type of error, expecting NetworkingManager NetworkingError")
                return
            }
            
            XCTAssertEqual(networkingError,
                           NetworkingManager.NetworkingError.decodingError(description: ""),
                           "Error should be decoding error")
        }
    }
}
