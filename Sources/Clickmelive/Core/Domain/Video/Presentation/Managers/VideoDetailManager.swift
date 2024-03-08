//
//  VideoDetailManager.swift
//  Clickmelive
//
//  Created by Can on 5.03.2024.
//

import Foundation

protocol VideoDetailManagerOutput {
    func videoDetailLoaded(video: Video)
}

final class VideoDetailManager {
    
    var output: VideoDetailManagerOutput?
    var failureOutput: FailureOutput?
    
    // MARK: - State
    var video: Video?
    
    private let videoDetailLoader: VideoDetailLoader
    private let videoUpdateListener: VideoUpdateListener
    
    init(videoDetailLoader: VideoDetailLoader,
         videoUpdateListener: VideoUpdateListener) {
        self.videoDetailLoader = videoDetailLoader
        self.videoUpdateListener = videoUpdateListener
    }
}

extension VideoDetailManager {
    func loadVideo(id: String) {
        videoDetailLoader.load(id: id) { [weak self] result in
            switch result {
            case let .success(video):
                self?.video = video
                self?.output?.videoDetailLoaded(video: video)
            case let .failure(error):
                self?.failureOutput?.failed(error: error)
            }
        }
    }
}


extension VideoDetailManager {
    func listen(id: String) {
        videoUpdateListener.listen(id: id) { [weak self] result in
            switch result {
            case let .success(video):
                self?.loadVideo(id: video.id)
            case let .failure(error):
                self?.failureOutput?.failed(error: error)
            }
        }
    }
}

