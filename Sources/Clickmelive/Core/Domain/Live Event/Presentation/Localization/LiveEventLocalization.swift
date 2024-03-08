//
//  LiveEventLocalization.swift
//  ClickmeliveCore
//
//  Created by Can on 4.03.2024.
//

import Foundation

final class LiveEventLocalization {
    
    var table: String { "LiveEvent" }
    var bundle: Bundle = Bundle.module
    
    static let shared = LiveEventLocalization()
    
    init() {}
    
    func estimatedStartingDate(day: String, month: String, time: String) -> String {
        let format = NSLocalizedString(
            "LiveEventEstimatedStartingDate",
            tableName: table,
            bundle: bundle,
            comment: "Title for items count")
    
        return String(format: format, day, month, time)
    }
    
    func itemsCount(_ count: Int) -> String {
        let format = NSLocalizedString(
            "LiveEventItemsCount",
            tableName: table,
            bundle: bundle,
            comment: "Title for items count")
    
        return String(format: format, count)
    }
    
    var statusReadyToStream: String {
        NSLocalizedString(
            "LiveEventStatusReadyToStream",
            tableName: table,
            bundle: bundle,
            comment: "Title for ready to stream status")
    }
    
    var statusReplayAvailable: String {
        NSLocalizedString(
            "LiveEventStatusReplayAvailable",
            tableName: table,
            bundle: bundle,
            comment: "Title for replay available status")
    }
    
    var statusStreamEnded: String {
        NSLocalizedString(
            "LiveEventStatusStreamEnded",
            tableName: table,
            bundle: bundle,
            comment: "Title for stream ended status")
    }
    
    var statusStreaming: String {
        NSLocalizedString(
            "LiveEventStatusStreaming",
            tableName: table,
            bundle: bundle,
            comment: "Title for streaming status")
    }
    
    var statusCancelled: String {
        NSLocalizedString(
            "LiveEventStatusCancelled",
            tableName: table,
            bundle: bundle,
            comment: "Title for cancelled status")
    }
}
