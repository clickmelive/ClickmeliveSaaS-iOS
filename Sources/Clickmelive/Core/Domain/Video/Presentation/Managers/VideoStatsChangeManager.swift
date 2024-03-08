//
//  VideoStatsChangeManager.swift
//  Clickmelive
//
//  Created by Can on 5.03.2024.
//

import Foundation

protocol VideoStatsChangeManagerOutput {
    func videoDetailUpdated(video: Video)
}

final class VideoStatsChangeManager {
    
    var output: VideoStatsChangeManagerOutput?
    var failureOutput: FailureOutput?
    
    private let videoStatsChangeListener: VideoStatsChangeListener
    
    init(videoStatsChangeListener: VideoStatsChangeListener) {
        self.videoStatsChangeListener = videoStatsChangeListener
    }
}

extension VideoStatsChangeManager {
    func listenVideoStats(id: String) {
        videoStatsChangeListener.listen(id: id) { [weak self] result in
            switch result {
            case let .success(video):
                self?.output?.videoDetailUpdated(video: video)
            case let .failure(error):
                self?.failureOutput?.failed(error: error)
            }
        }
    }
}
