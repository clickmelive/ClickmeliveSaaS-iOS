//
//  LiveEventLikeManager.swift
//  Clickmelive
//
//  Created by Can on 5.03.2024.
//

import Foundation

protocol LiveEventLikeManagerOutput {
    func isLiveEventLiked(liveEvent: LiveEvent, like: Bool)
}

final class LiveEventLikeManager {
    
    var output: LiveEventLikeManagerOutput?
    var failureOutput: FailureOutput?
    
    private let liveEventLiker: LiveEventLiker
    
    init(liveEventLiker: LiveEventLiker) {
        self.liveEventLiker = liveEventLiker
    }
}

extension LiveEventLikeManager {
    func like(liveEventId: String, userId: String, like: Bool) {
        liveEventLiker.like(liveEventId: liveEventId, userId: userId, like: like) { [weak self] result in
            switch result {
            case let .success(liveEvent):
                self?.output?.isLiveEventLiked(liveEvent: liveEvent, like: like)
            case let .failure(error):
                self?.failureOutput?.failed(error: error)
            }
        }
    }
}
