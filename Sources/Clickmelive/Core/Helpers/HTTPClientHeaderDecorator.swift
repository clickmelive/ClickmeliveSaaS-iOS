//
//  HTTPClientHeaderDecorator.swift
//  Clickmelive
//
//  Created by Can on 8.03.2024.
//

import Foundation

class HTTPClientHeaderDecorator: HTTPClient {
    
    private let decoratee: HTTPClient
    private let headers: [String: String]
    
    init(decoratee: HTTPClient,
         headers: [String: String]) {
        self.decoratee = decoratee
        self.headers = headers
    }
    
    public func execute(with urlRequest: URLRequest, completion: @escaping (HTTPClient.Result) -> Void) -> HTTPClientTask {
        var signedRequest = urlRequest
        
        headers.forEach { key, value in
            signedRequest.addValue(value, forHTTPHeaderField: key)
        }
        
        return decoratee.execute(with: signedRequest, completion: completion)
    }
}
