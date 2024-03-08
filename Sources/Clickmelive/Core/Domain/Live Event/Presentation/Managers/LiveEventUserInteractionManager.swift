//
//  LiveEventUserInteractionManager.swift
//  Clickmelive
//
//  Created by Can on 5.03.2024.
//

import Foundation

protocol LiveEventUserInteractionManagerOutput {
    func liveEventUserInteractionLoaded(liveEventUserInteraction: LiveEventUserInteraction)
}

final class LiveEventUserInteractionManager {
    
    var output: LiveEventUserInteractionManagerOutput?
    var failureOutput: FailureOutput?
    
    private let liveEventUserInteractionLoader: LiveEventUserInteractionLoader
    
    init(liveEventUserInteractionLoader: LiveEventUserInteractionLoader) {
        self.liveEventUserInteractionLoader = liveEventUserInteractionLoader
    }
}

extension LiveEventUserInteractionManager {
    func loadLiveEventUserInteraction(liveEventId: String, userId: String) {
        liveEventUserInteractionLoader.load(liveEventId: liveEventId, userId: userId) { [weak self] result in
            switch result {
            case let .success(liveEventUserInteraction):
                self?.output?.liveEventUserInteractionLoaded(liveEventUserInteraction: liveEventUserInteraction)
            case let .failure(error):
                self?.failureOutput?.failed(error: error)
            }
        }
    }
}
