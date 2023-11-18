//
//  MockURLSessionProtocol.swift
//  TheMovieDB
//
//  Created by Mohammad Zulqurnain on 17/11/2023.
//

#if DEBUG
import Foundation

class MockURLSessionProtocol: URLProtocol {
    
    static var loadingHandler: (() -> (HTTPURLResponse, Data?))?
    
    override class func canInit(with request: URLRequest) -> Bool {
        return true
    }
    
    override class func canonicalRequest(for request: URLRequest) -> URLRequest {
        return request
    }
    
    override func startLoading() {
        
        guard let handler = MockURLSessionProtocol.loadingHandler else {
            fatalError(Constants.loadingHandlerNotSetError)
        }
        
        let (response, data) = handler()
        client?.urlProtocol(self, didReceive: response, cacheStoragePolicy: .notAllowed)
        if let data = data {
            client?.urlProtocol(self, didLoad: data)
        }
        client?.urlProtocolDidFinishLoading(self)
    }
    
    override func stopLoading() {
        
    }
}
#endif
