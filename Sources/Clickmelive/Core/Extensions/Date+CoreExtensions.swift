//
//  Date+Extensions.swift
//  ClickmeliveCore
//
//  Created by Can on 4.03.2024.
//

import Foundation

extension Date {
    /// Returns the day of the month as a string.
    func dayAsString() -> String {
        return DateFormatter.dayAsString.string(from: self)
    }
    
    /// Returns the month name as a string.
    func monthAsString() -> String {
        return DateFormatter.monthAsString.string(from: self)
    }
    
    /// Returns the time in HH:mm format.
    func timeAsString() -> String {
        return DateFormatter.timeAsString.string(from: self)
    }
}
