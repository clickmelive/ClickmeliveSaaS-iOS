//
//  LiveEventStatsChangeManager.swift
//  Clickmelive
//
//  Created by Can on 5.03.2024.
//

import Foundation

protocol LiveEventStatsChangeManagerOutput {
    func liveEventDetailUpdated(liveEvent: LiveEvent)
}

final class LiveEventStatsChangeManager {
    
    var output: LiveEventStatsChangeManagerOutput?
    var failureOutput: FailureOutput?
    
    private let liveEventStatsChangeListener: LiveEventStatsChangeListener
    
    init(liveEventStatsChangeListener: LiveEventStatsChangeListener) {
        self.liveEventStatsChangeListener = liveEventStatsChangeListener
    }
}

extension LiveEventStatsChangeManager {
    func listenLiveEventStats(id: String) {
        liveEventStatsChangeListener.listen(id: id) { [weak self] result in
            switch result {
            case let .success(liveEvent):
                self?.output?.liveEventDetailUpdated(liveEvent: liveEvent)
            case let .failure(error):
                self?.failureOutput?.failed(error: error)
            }
        }
    }
}
