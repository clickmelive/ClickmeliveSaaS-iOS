//
//  VideoGQL+DomainConversion.swift
//  ClickmeliveCore
//
//  Created by Can on 4.03.2024.
//

import ClickmeliveSaasAPI
import Foundation

extension VideoGQL {
    var toVideo: Video {
        let nonNilTags = tags?.compactMap { $0 }
        let tags = nonNilTags?.compactMap { Tag(title: $0) } ?? []
     
        let nonNilItems = items?.compactMap { $0 }
        let items: [Item] = nonNilItems?.compactMap { item in
            return Item(name: item, imageUrl: nil, deeplinkUrl: nil)
        } ?? []
        
        return .init(id: id, title: title, tags: tags, items: items, thumbnailUrl: thumbnailUrl, videoUrl: videoUrl, totalViewer: totalViewer, totalLikeCount: totalLikeCount)
    }
}
