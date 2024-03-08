//
//  UserAuthenticator.swift
//  Clickmelive
//
//  Created by Can on 8.03.2024.
//

protocol UserAuthenticator {
    typealias Result = Swift.Result<APIConfiguration, Error>

    func authenticate(apiKey: String, completion: @escaping (Result) -> Void)
}
