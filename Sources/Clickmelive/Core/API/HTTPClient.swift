//
//  HTTPClient.swift
//  Clickmelive
//
//  Created by Can on 8.03.2024.
//

import Foundation

protocol HTTPClientTask {
    func cancel()
}

protocol HTTPClient {
    typealias Result = Swift.Result<(Data, HTTPURLResponse), Error>
    
    /// The completion handler can be invoked in any thread.
    /// Clients are responsible to dispatch to appropriate threads, if needed.
    @discardableResult
    func execute(with urlRequest: URLRequest, completion: @escaping (Result) -> Void) -> HTTPClientTask
}

