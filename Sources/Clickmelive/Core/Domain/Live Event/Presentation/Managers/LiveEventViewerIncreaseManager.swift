//
//  LiveEventViewerIncreaseManager.swift
//  Clickmelive
//
//  Created by Can on 5.03.2024.
//

import Foundation

protocol LiveEventViewerIncreaseManagerOutput {
    func liveEventViewerIncreased()
}

final class LiveEventViewerIncreaseManager {
    
    var output: LiveEventViewerIncreaseManagerOutput?
    var failureOutput: FailureOutput?
    
    private let liveEventViewerIncreaser: LiveEventViewerIncreaser
    
    init(liveEventViewerIncreaser: LiveEventViewerIncreaser) {
        self.liveEventViewerIncreaser = liveEventViewerIncreaser
    }
}

extension LiveEventViewerIncreaseManager {
    func increaseLiveEventViewer(id: String, userId: String) {
        liveEventViewerIncreaser.increase(id: id, userId: userId) { [weak self] result in
            switch result {
            case .success:
                self?.output?.liveEventViewerIncreased()
            case let .failure(error):
                self?.failureOutput?.failed(error: error)
            }
        }
    }
}
