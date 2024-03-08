//
//  VideoUserInteractionViewModel.swift
//  ClickmeliveCore
//
//  Created by Can on 4.03.2024.
//

import Foundation

final class VideoUserInteractionViewModel {
    private let model: VideoUserInteraction
    
    init(model: VideoUserInteraction) {
        self.model = model
    }
    
    var like: Bool {
        model.like
    }
}
