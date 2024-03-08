//
//  LiveEventViewerViewModel.swift
//  ClickmeliveCore
//
//  Created by Can on 4.03.2024.
//

import Foundation

final class LiveEventViewerViewModel {
    private let model: LiveEventViewer
    
    init(model: LiveEventViewer) {
        self.model = model
    }
    
    var viewerCount: String {
        model.viewerCount.toAbbreviateNumber()
    }
    
    var isViewerCountHidden: Bool {
        model.viewerCount <= 0
    }
}

