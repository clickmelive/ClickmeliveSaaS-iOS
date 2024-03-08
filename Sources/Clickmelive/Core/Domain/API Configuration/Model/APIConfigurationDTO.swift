//
//  APIConfigurationDTO.swift
//  Clickmelive
//
//  Created by Can on 5.03.2024.
//

import Foundation

struct APIConfigurationDTO: Codable {
    let apiUrl: String?
    let wssUrl: String?
    let domain: String?
    
    var toAPIConfiguration: APIConfiguration {
        .init(apiUrl: apiUrl ?? "",
              wssUrl: wssUrl ?? "",
              domain: domain ?? "")
    }
}
