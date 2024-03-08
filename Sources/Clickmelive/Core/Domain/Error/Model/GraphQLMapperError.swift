//
//  GraphQLMapperError.swift
//  ClickmeliveCore
//
//  Created by Can on 2.03.2024.
//

import Foundation

enum GraphQLMapperError: Error, LocalizedError {
    case noDataReceived
    case dataMissing

    var errorDescription: String? {
        switch self {
            case .noDataReceived:
                return "No data received from the query."
            case .dataMissing:
                return "Expected data is missing from the query result."
        }
    }
}
