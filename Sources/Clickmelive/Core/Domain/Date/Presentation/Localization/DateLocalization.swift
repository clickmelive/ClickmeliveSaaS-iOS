//
//  DateLocalization.swift
//  Clickmelive
//
//  Created by Can on 22.03.2024.
//

import Foundation

final class DateLocalization {
    
    var table: String { "Date" }
    var bundle: Bundle = Bundle.module
    
    static let shared = DateLocalization()
    
    init() {}
    
    var today: String {
        NSLocalizedString(
            "DateToday",
            tableName: table,
            bundle: bundle,
            comment: "Title for today")
    }
}
