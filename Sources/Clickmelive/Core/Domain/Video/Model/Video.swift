//
//  Video.swift
//  ClickmeliveCore
//
//  Created by Can on 4.03.2024.
//

import Foundation

public struct Video {
    public let id: String
    public let title: String
    public let tags: [Tag]
    public let items: [Item]
    public let thumbnailUrl: String?
    public let videoUrl: String?
    public let totalViewer: Int
    public let totalLikeCount: Int
}
