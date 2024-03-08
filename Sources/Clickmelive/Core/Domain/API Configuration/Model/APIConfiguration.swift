//
//  APIConfiguration.swift
//  Clickmelive
//
//  Created by Can on 5.03.2024.
//

import Foundation

struct APIConfiguration {
    let apiUrl: String
    let wssUrl: String
    let domain: String
    
    var toAPIConfigurationDTO: APIConfigurationDTO {
        APIConfigurationDTO(apiUrl: self.apiUrl, wssUrl: self.wssUrl, domain: self.domain)
    }
}
