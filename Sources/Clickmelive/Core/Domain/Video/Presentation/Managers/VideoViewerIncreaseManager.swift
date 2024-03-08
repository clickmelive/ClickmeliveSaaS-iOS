//
//  VideoViewerIncreaseManager.swift
//  Clickmelive
//
//  Created by Can on 5.03.2024.
//

import Foundation

protocol VideoViewerIncreaseManagerOutput {
    func videoViewerIncreased()
}

final class VideoViewerIncreaseManager {
    
    var output: VideoViewerIncreaseManagerOutput?
    var failureOutput: FailureOutput?
    
    private let videoViewerIncreaser: VideoViewerIncreaser
    
    init(videoViewerIncreaser: VideoViewerIncreaser) {
        self.videoViewerIncreaser = videoViewerIncreaser
    }
}

extension VideoViewerIncreaseManager {
    func increaseVideoViewer(id: String, userId: String) {
        videoViewerIncreaser.increase(id: id, userId: userId) { [weak self] result in
            switch result {
            case .success:
                self?.output?.videoViewerIncreased()
            case let .failure(error):
                self?.failureOutput?.failed(error: error)
            }
        }
    }
}
