//
//  APIConfigurationMapper.swift
//  Clickmelive
//
//  Created by Can on 8.03.2024.
//

import Foundation

final class APIConfigurationMapper {
    
    private static var OK_200: Int { return 200 }
    
    enum Error: Swift.Error {
        case invalidStatusCode
        case invalidData
    }
    
    static func map(_ data: Data, from response: HTTPURLResponse) throws -> APIConfiguration {
        guard response.statusCode == OK_200 else {
            throw Error.invalidStatusCode
        }
        
        do {
            let root = try JSONDecoder().decode(APIConfigurationDTO.self, from: data)
            return root.toAPIConfiguration
        } catch {
            throw Error.invalidData
        }
    }
}
