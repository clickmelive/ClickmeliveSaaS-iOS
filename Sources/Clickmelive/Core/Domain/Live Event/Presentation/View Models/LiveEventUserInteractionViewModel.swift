//
//  LiveEventUserInteractionViewModel.swift
//  ClickmeliveCore
//
//  Created by Can on 4.03.2024.
//

import Foundation

final class LiveEventUserInteractionViewModel {
    private let model: LiveEventUserInteraction
    
    init(model: LiveEventUserInteraction) {
        self.model = model
    }
    
    var like: Bool {
        model.like
    }
}
