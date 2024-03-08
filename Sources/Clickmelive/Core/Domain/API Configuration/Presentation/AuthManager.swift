//
//  AuthManager.swift
//  Clickmelive
//
//  Created by Can on 8.03.2024.
//

import Foundation

protocol AuthManagerOutput {
    func userAuthenticated(apiConfiguration: APIConfiguration)
}

final class AuthManager {
    
    var output: AuthManagerOutput?
    var failureOutput: FailureOutput?
    
    private let userAuthenticator: UserAuthenticator
    
    public init(userAuthenticator: UserAuthenticator) {
        self.userAuthenticator = userAuthenticator
    }
}

extension AuthManager {
    func authenticate(apiKey: String) {
        userAuthenticator.authenticate(apiKey: apiKey) { [weak self] result in
            switch result {
            case let .success(apiConfiguration):
                self?.output?.userAuthenticated(apiConfiguration: apiConfiguration)
            case let .failure(error):
                self?.failureOutput?.failed(error: error)
            }
        }
    }
}

