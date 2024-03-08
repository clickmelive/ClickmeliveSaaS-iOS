//
//  LiveEventDetailManager.swift
//  Clickmelive
//
//  Created by Can on 5.03.2024.
//

import Foundation

protocol LiveEventDetailManagerOutput {
    func liveEventDetailLoaded(liveEvent: LiveEvent)
}

final class LiveEventDetailManager {
    
    var output: LiveEventDetailManagerOutput?
    var failureOutput: FailureOutput?
    
    // MARK: - State
    var liveEvent: LiveEvent?
    
    private let liveEventDetailLoader: LiveEventDetailLoader
    private let liveEventUpdateListener: LiveEventUpdateListener
    
    init(liveEventDetailLoader: LiveEventDetailLoader,
         liveEventUpdateListener: LiveEventUpdateListener) {
        self.liveEventDetailLoader = liveEventDetailLoader
        self.liveEventUpdateListener = liveEventUpdateListener
    }
}

extension LiveEventDetailManager {
    func loadEventDetail(id: String) {
        liveEventDetailLoader.load(id: id) { [weak self] result in
            switch result {
            case let .success(liveEvent):
                self?.liveEvent = liveEvent
                self?.output?.liveEventDetailLoaded(liveEvent: liveEvent)
            case let .failure(error):
                self?.failureOutput?.failed(error: error)
            }
        }
    }
}

extension LiveEventDetailManager {
    func listen(id: String) {
        liveEventUpdateListener.listen(id: id) { [weak self] result in
            switch result {
            case let .success(liveEvent):
                self?.loadEventDetail(id: liveEvent.id)
            case let .failure(error):
                self?.failureOutput?.failed(error: error)
            }
        }
    }
}

