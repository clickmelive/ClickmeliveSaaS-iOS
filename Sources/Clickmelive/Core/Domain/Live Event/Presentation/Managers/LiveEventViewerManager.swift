//
//  LiveEventViewerCountManager.swift
//  Clickmelive
//
//  Created by Can on 5.03.2024.
//

import Foundation

protocol LiveEventViewerManagerOutput {
    func loadedLiveEventViewer(viewerCount: LiveEventViewer)
}

final class LiveEventViewerManager {
    
    var output: LiveEventViewerManagerOutput?
    var failureOutput: FailureOutput?
    
    private let liveEventViewerLoader: LiveEventViewerLoader
    
    init(liveEventViewerLoader: LiveEventViewerLoader) {
        self.liveEventViewerLoader = liveEventViewerLoader
    }
}

extension LiveEventViewerManager {
    func loadViewerCount(eventId: String) {
        liveEventViewerLoader.load(eventId: eventId) { [weak self] result in
            switch result {
            case let .success(viewerCount):
                self?.output?.loadedLiveEventViewer(viewerCount: viewerCount)
            case let .failure(error):
                self?.failureOutput?.failed(error: error)
            }
        }
    }
}
