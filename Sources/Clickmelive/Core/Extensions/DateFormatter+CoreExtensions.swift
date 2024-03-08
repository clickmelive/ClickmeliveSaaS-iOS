//
//  DateFormatter+Extensions.swift
//  ClickmeliveCore
//
//  Created by Can on 4.03.2024.
//

import Foundation

extension DateFormatter {
    static func createFormatter(dateFormat: String, timeZone: TimeZone = .current, locale: Locale = Locale(identifier: "tr_TR")) -> DateFormatter {
        let formatter = DateFormatter()
        formatter.dateFormat = dateFormat
        formatter.calendar = Calendar(identifier: .iso8601)
        formatter.timeZone = timeZone
        formatter.locale = locale
        return formatter
    }

    static let iso8601WithMilliseconds: DateFormatter = createFormatter(dateFormat: "yyyy-MM-dd'T'HH:mm:ss.SSSZ")
    
    static let dayAsString: DateFormatter = createFormatter(dateFormat: "d")
    
    static let monthAsString: DateFormatter = createFormatter(dateFormat: "MMMM")
    
    static let timeAsString: DateFormatter = createFormatter(dateFormat: "HH:mm")
}
