//
//  URLRequestBuilder.swift
//  Clickmelive
//
//  Created by Can on 8.03.2024.
//

import Foundation

public enum HTTPMethod: String {
    case get = "GET"
    case post = "POST"
    case patch = "PATCH"
    case delete = "DELETE"
    case put = "PUT"
}

public protocol URLRequestBuilder {
    var path: String { get }
    var parameters: [String: Any]? { get }
    var queryItems: [URLQueryItem]? { get }
    var method: HTTPMethod { get }
}

extension URLRequestBuilder {
    
    private var acceptHTTPHeaderField: String {
        return "Accept"
    }
    
    private var contentTypeHTTPHeaderField: String {
        return "Content-Type"
    }
    
    private var jsonHTTPHeaderFieldValue: String {
        return "application/json"
    }
    
    public func urlRequest(baseURL: URL) -> URLRequest {
        var urlComponents = URLComponents(string: baseURL.absoluteString)
        urlComponents?.path = path
        if let queryItems = queryItems {
            if(queryItems.count > 0){
                urlComponents?.queryItems = queryItems
            }
        }
        
        guard let requestURL = urlComponents?.url else {
            fatalError("URL could not be built")
        }
        
        var request = URLRequest(url: requestURL)
        
        request.httpMethod = method.rawValue
        request.setValue(jsonHTTPHeaderFieldValue, forHTTPHeaderField: acceptHTTPHeaderField)
        request.setValue(jsonHTTPHeaderFieldValue, forHTTPHeaderField: contentTypeHTTPHeaderField)
        
        if let parameters = parameters {
            if(parameters.count > 0){
                let jsonData = try? JSONSerialization.data(withJSONObject: parameters)
                request.httpBody = jsonData
            }
        }
        
        return request
    }
}
