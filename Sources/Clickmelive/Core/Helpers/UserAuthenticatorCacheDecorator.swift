//
//  UserAuthenticatorCacheDecorator.swift
//  Clickmelive
//
//  Created by Can on 8.03.2024.
//

class UserAuthenticatorCacheDecorator: UserAuthenticator {
    
    private let decoratee: UserAuthenticator
    private let userDefaults: CMLUserDefaults
    
    init(decoratee: UserAuthenticator,
         userDefaults: CMLUserDefaults) {
        self.decoratee = decoratee
        self.userDefaults = userDefaults
    }
    
    func authenticate(apiKey: String, completion: @escaping (UserAuthenticator.Result) -> Void) {
        if let cachedConfiguration = userDefaults.apiConfiguration {
            // Return the cached configuration without making a network request
            completion(.success(cachedConfiguration))
            return
        }
        
        // No cached configuration found, proceed with the actual authentication
        decoratee.authenticate(apiKey: apiKey) { [weak self] result in
            switch result {
            case .success(let configuration):
                // Cache the successful configuration for future use
                self?.userDefaults.apiConfiguration = configuration
                completion(.success(configuration))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
}
