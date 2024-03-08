//
//  VideoLikeManager.swift
//  Clickmelive
//
//  Created by Can on 6.03.2024.
//

import Foundation

protocol VideoLikeManagerOutput {
    func isVideoLiked(video: Video, like: Bool)
}

final class VideoLikeManager {
    
    var output: VideoLikeManagerOutput?
    var failureOutput: FailureOutput?
    
    private let videoLiker: VideoLiker
    
    public init(videoLiker: VideoLiker) {
        self.videoLiker = videoLiker
    }
}

extension VideoLikeManager {
    func like(videoId: String, userId: String, like: Bool) {
        videoLiker.like(videoId: videoId, userId: userId, like: like) { [weak self] result in
            switch result {
            case let .success(video):
                self?.output?.isVideoLiked(video: video, like: like)
            case let .failure(error):
                self?.failureOutput?.failed(error: error)
            }
        }
    }
}
