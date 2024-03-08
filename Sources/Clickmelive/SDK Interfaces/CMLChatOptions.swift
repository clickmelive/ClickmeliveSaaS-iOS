//
//  CMLChatOptions.swift
//  Clickmelive
//
//  Created by Can on 5.03.2024.
//

public class CMLChatOptions {
    private var username: String
    
    private init(username: String) {
        self.username = username
    }
    
    public class Builder {
        
        private var username: String?
        
        public init() {}
        
        public func setUsername(_ username: String) -> Builder {
            self.username = username
            return self
        }
        
        public func build() -> CMLChatOptions {
            guard let username = self.username else {
                fatalError("Error: username is required.")
            }
            return CMLChatOptions(username: username)
        }
    }
    
    func getUsername() -> String {
        return username
    }
}
