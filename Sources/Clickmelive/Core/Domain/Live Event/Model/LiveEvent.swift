//
//  LiveEvent.swift
//  ClickmeliveCore
//
//  Created by Can on 2.03.2024.
//

import Foundation
import ClickmeliveSaasAPI

public struct LiveEvent {
    public let id: String
    public let status: LiveEventStatus
    public let title: String
    public let tags: [Tag]
    public let items: [Item]
    public let playbackUrl: String?
    public let teaserUrl: String?
    public let replayUrl: String?
    public let thumbnailUrl: String?
    public let totalViewer: Int
    public let totalLikeCount: Int
    public let estimatedStartingDate: String?
}
