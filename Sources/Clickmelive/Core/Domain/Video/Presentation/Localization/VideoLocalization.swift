//
//  VideoLocalization.swift
//  ClickmeliveCore
//
//  Created by Can on 4.03.2024.
//

import Foundation

final class VideoLocalization {
    
    var table: String { "Video" }
    var bundle: Bundle = Bundle.module
    
    static let shared = VideoLocalization()
    
    init() {}
    
    func itemsCount(_ count: Int) -> String {
        let format = NSLocalizedString(
            "VideoItemsCount",
            tableName: table,
            bundle: bundle,
            comment: "Title for items count")
    
        return String(format: format, count)
    }
    
    var status: String {
        NSLocalizedString(
            "VideoStatus",
            tableName: table,
            bundle: bundle,
            comment: "Title for video status")
    }
}
