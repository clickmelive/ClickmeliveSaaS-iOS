//
//  VideoViewModel.swift
//  ClickmeliveCore
//
//  Created by Can on 4.03.2024.
//

import Foundation

final class VideoViewModel {
    private let model: Video
    
    init(model: Video) {
        self.model = model
    }
    
    var id: String {
        model.id
    }
    
    var title: String {
        model.title
    }
    
    var itemsCount: String {
        VideoLocalization.shared.itemsCount(model.items.count)
    }
    
    var isItemsHidden: Bool {
        model.items.isEmpty
    }
    
    var firstItemImageURL: URL? {
        model.items.first?.imageUrl.asURL
    }
    
    var thumbnailUrl: URL? {
        model.thumbnailUrl.asURL
    }
    
    var videoUrl: URL? {
        model.videoUrl.asURL
    }
    
    var totalViewer: String {
        model.totalViewer.toAbbreviateNumber()
    }
    
    var totalLikeCount: String {
        model.totalLikeCount.toAbbreviateNumber()
    }
    
    var statusTitle: String {
        VideoLocalization.shared.status
    }
}
