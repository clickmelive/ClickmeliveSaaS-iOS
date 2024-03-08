//
//  LiveEventGQL+DomainConversion.swift
//  ClickmeliveCore
//
//  Created by Can on 4.03.2024.
//

import ClickmeliveSaasAPI
import Foundation

extension LiveEventGQL {
    var toLiveEvent: LiveEvent {
        let nonNilTags = tags?.compactMap { $0 }
        let tags = nonNilTags?.compactMap { Tag(title: $0) } ?? []
     
        let nonNilItems = items?.compactMap { $0 }
        let items: [Item] = nonNilItems?.compactMap { item in
            return Item(name: item, imageUrl: nil, deeplinkUrl: nil)
        } ?? []
        
        let status = LiveEventStatus.getLiveEventStatus(from: self.status)
        
        return .init(id: id, status: status, title: title, tags: tags, items: items, playbackUrl: playbackUrl, teaserUrl: teaserUrl, replayUrl: replayUrl, thumbnailUrl: thumbnailUrl, totalViewer: totalViewer, totalLikeCount: totalLikeCount, estimatedStartingDate: estimatedStartingDate)
    }
}
