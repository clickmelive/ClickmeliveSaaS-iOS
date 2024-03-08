//
//  AppEnvironment.swift
//  Clickmelive
//
//  Created by Can on 8.03.2024.
//

import Foundation

enum AppEnvironment {
    case production
}

extension AppEnvironment {
    static var currentState: AppEnvironment {
        .production
    }
}

extension AppEnvironment {
    static var baseURL: URL {
        switch AppEnvironment.currentState {
        case .production:
            return URL(string: Servers.production)!
        }
    }
}

extension AppEnvironment {
    static var showLog: Bool {
        switch AppEnvironment.currentState {
        case .production:
            return false
        }
    }
}
