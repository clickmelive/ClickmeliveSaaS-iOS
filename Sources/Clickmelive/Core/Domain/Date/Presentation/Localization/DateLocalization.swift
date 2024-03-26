//
//  DateLocalization.swift
//  Clickmelive
//
//  Created by Can on 22.03.2024.
//

import Foundation

final class DateLocalization {
    
    var table: String { "Date" }
    
    static let shared = DateLocalization()
    
    init() {}
    
    var today: String {
        NSLocalizedString(
            "DateToday",
            tableName: table,
            bundle: .clickmeliveBundle,
            comment: "Title for today")
    }
}
