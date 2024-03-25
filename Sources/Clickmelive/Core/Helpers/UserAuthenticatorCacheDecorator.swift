//
//  UserAuthenticatorCacheDecorator.swift
//  Clickmelive
//
//  Created by Can on 8.03.2024.
//

class UserAuthenticatorCacheDecorator: UserAuthenticator {
    
    private let decoratee: UserAuthenticator
    private let userDefaults: CMLUserDefaults
    
    init(decoratee: UserAuthenticator, userDefaults: CMLUserDefaults) {
        self.decoratee = decoratee
        self.userDefaults = userDefaults
    }
    
    func authenticate(apiKey: String, completion: @escaping (UserAuthenticator.Result) -> Void) {
        // Always attempt to authenticate by calling the endpoint
        decoratee.authenticate(apiKey: apiKey) { [weak self] result in
            switch result {
            case let .success(configuration):
                // Cache the successful configuration for future use
                self?.userDefaults.apiConfiguration = configuration
                completion(.success(configuration))
            case let .failure(error):
                // Authentication failed, check if there's a cached configuration
                if let cachedConfiguration = self?.userDefaults.apiConfiguration {
                    // Return the cached configuration
                    completion(.success(cachedConfiguration))
                } else {
                    // No cached configuration, forward the authentication error
                    completion(.failure(error))
                }
            }
        }
    }
}
