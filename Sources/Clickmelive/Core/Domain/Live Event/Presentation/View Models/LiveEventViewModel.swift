//
//  LiveEventViewModel.swift
//  ClickmeliveCore
//
//  Created by Can on 4.03.2024.
//

import Foundation

final class LiveEventViewModel {
    private let model: LiveEvent
    
    init(model: LiveEvent) {
        self.model = model
    }
    
    var id: String {
        model.id
    }
    
    var title: String {
        model.title
    }
    
    var status: LiveEventStatus {
        model.status
    }
    
    var itemsCount: String {
        LiveEventLocalization.shared.itemsCount(model.items.count)
    }
    
    var isItemsHidden: Bool {
        model.items.isEmpty
    }
    
    var firstItemImageURL: URL? {
        model.items.first?.imageUrl.asURL
    }
    
    var playbackUrl: URL? {
        model.playbackUrl.asURL
    }
    
    var teaserUrl: URL? {
        model.teaserUrl.asURL
    }
    
    var replayUrl: URL? {
        model.replayUrl.asURL
    }
    
    var thumbnailUrl: URL? {
        model.thumbnailUrl.asURL
    }
    
    var totalViewer: String {
        model.totalViewer.toAbbreviateNumber()
    }
    
    var totalLikeCount: String {
        model.totalLikeCount.toAbbreviateNumber()
    }
    
    var replayAvailable: Bool {
        model.replayUrl != nil
    }
    
    var estimatedStartingDate: String? {
        model.estimatedStartingDate
    }
    
    var statusTitle: String? {
        guard replayUrl == nil else {
            return LiveEventLocalization.shared.statusReplayAvailable
        }
        
        switch status {
        case .None:
            return nil
        case .Created,
             .Teaser:
            guard let estimatedStartingDate = model.estimatedStartingDate,
                  let date = DateFormatter.iso8601WithMilliseconds.date(from: estimatedStartingDate) else {
                return nil
            }
            return LiveEventLocalization.shared.estimatedStartingDate(
                day: date.dayAsString(),
                month: date.monthAsString(),
                time: date.timeAsString()
            )
        case .ReadyToStream:
            return LiveEventLocalization.shared.statusReadyToStream
        case .Streaming:
            return LiveEventLocalization.shared.statusStreaming
        case .StreamEnded:
            return LiveEventLocalization.shared.statusStreamEnded
        case .Cancelled:
            return LiveEventLocalization.shared.statusCancelled
        }
    }
}

