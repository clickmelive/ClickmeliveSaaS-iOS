//
//  UserDefaults.swift
//  Clickmelive
//
//  Created by Can on 5.03.2024.
//

import UIKit

final class CMLUserDefaults {
    private let defaults: UserDefaults
   
    init(defaults: UserDefaults = .standard) {
        self.defaults = defaults
    }

    var userId: String {
        get {
            return defaults[#function] ?? ""
        }
        set {
            defaults[#function] = newValue
        }
    }
    
    var apiConfiguration: APIConfiguration? {
        get {
            do {
                return try defaults.loadObject(forKey: "apiConfiguration", castTo: APIConfigurationDTO.self).toAPIConfiguration
            } catch {
                print("Failed to get APIConfiguration: \(error)")
                return nil
            }
        }
        set {
            do {
                try defaults.saveObject(newValue?.toAPIConfigurationDTO, forKey: "apiConfiguration")
            } catch {
                print("Failed to save APIConfiguration: \(error)")
            }
        }
    }
}
