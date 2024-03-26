//
//  ItemLocalization.swift
//  Clickmelive
//
//  Created by Can on 22.03.2024.
//

import Foundation

final class ItemLocalization {
    
    var table: String { "Item" }
    
    init() {}
    
    func itemsCount(_ count: Int) -> String {
        let format = NSLocalizedString(
            "ItemsCount",
            tableName: table,
            bundle: .clickmeliveBundle,
            comment: "Title for items count")
    
        return String(format: format, count)
    }
}

