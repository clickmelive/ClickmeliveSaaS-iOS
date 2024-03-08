//
//  AuthEndpoints.swift
//  Clickmelive
//
//  Created by Can on 8.03.2024.
//

import Foundation

public enum AuthEndpoints: URLRequestBuilder {
    case getApiUrl(apiKey: String)
}

extension AuthEndpoints {
    public var path: String {
        switch self {
        case .getApiUrl:
            return "/prod/tenants/apiUrl"
        }
    }
}

extension AuthEndpoints {
    public var parameters: [String: Any]? {
        switch self {
        case .getApiUrl:
            return [:]
        }
    }
}

extension AuthEndpoints {
    public var queryItems: [URLQueryItem]? {
        switch self {
        case let .getApiUrl(apiKey):
            return [URLQueryItem(name: "apiKey", value: apiKey)]
        }
    }
}

extension AuthEndpoints {
    public var method: HTTPMethod {
        switch self {
        case .getApiUrl:
            return .get
        }
    }
}
