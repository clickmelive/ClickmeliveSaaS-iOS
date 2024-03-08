//
//  VideoPlayer+OutputHandlers.swift
//  Clickmelive
//
//  Created by Can on 5.03.2024.
//

extension PlayerUIComposer {
    final class VideoDetailManagerOutputHandler: VideoDetailManagerOutput {
        
        private weak var controller: PlayerViewController?
        private let imageLoader: ImageLoader
        
        init(controller: PlayerViewController,
             imageLoader: ImageLoader) {
            self.controller = controller
            self.imageLoader = imageLoader
        }
        
        func videoDetailLoaded(video: Video) {
            let videoViewModel = VideoViewModel(model: video)
            controller?.setVideoDetail(with: videoViewModel, imageLoader: imageLoader)
        }
    }
}

extension PlayerUIComposer {
    final class VideoStatsChangeManagerOutputHandler: VideoStatsChangeManagerOutput {
        
        private weak var controller: PlayerViewController?
        private let imageLoader: ImageLoader
        
        init(controller: PlayerViewController,
             imageLoader: ImageLoader) {
            self.controller = controller
            self.imageLoader = imageLoader
        }
        
        func videoDetailUpdated(video: Video) {
            let videoViewModel = VideoViewModel(model: video)
            controller?.updateStats(with: videoViewModel)
        }
    }
}

extension PlayerUIComposer {
    final class VideoUserInteractionManagerOutputHandler: VideoUserInteractionManagerOutput {
        
        private weak var controller: PlayerViewController?
        
        init(controller: PlayerViewController) {
            self.controller = controller
        }
        
        func videoUserInteractionLoaded(videoUserInteraction: VideoUserInteraction) {
            controller?.updateLikeStatus(with: videoUserInteraction.like, withAnimation: false)
        }
    }
}

extension PlayerUIComposer {
    final class VideoLikeManagerOutputHandler: VideoLikeManagerOutput {
        
        private weak var controller: PlayerViewController?
        private let userId: String
       
        init(controller: PlayerViewController,
             userId: String) {
            self.controller = controller
            self.userId = userId
           
        }
        
        func isVideoLiked(video: Video, like: Bool) {
            controller?.updateLikeStatus(with: like, withAnimation: true)
        }
    }
}

extension PlayerUIComposer {
    final class VideoPlayerViewControllerOutputHandler: PlayerViewControllerOutput {
        
        private weak var controller: PlayerViewController?
        private let videoId: String
        private let userId: String
        private let videoDetailManager: VideoDetailManager
        private let videoLikeManager: VideoLikeManager
        private let onItemsTapped: ([Item]) -> Void
        
        init(controller: PlayerViewController,
             videoId: String,
             userId: String,
             videoDetailManager: VideoDetailManager,
             videoLikeManager: VideoLikeManager,
             onItemsTapped: @escaping ([Item]) -> Void) {
            self.controller = controller
            self.videoId = videoId
            self.userId = userId
            self.videoDetailManager = videoDetailManager
            self.videoLikeManager = videoLikeManager
            self.onItemsTapped = onItemsTapped
        }
        
        func itemsTapped() {
            let items = videoDetailManager.video?.items ?? []
            onItemsTapped(items)
        }
        
        func likeTapped(like: Bool) {
            videoLikeManager.like(videoId: videoId, userId: userId, like: !like)
        }
        
        func messageSendTapped(message: String) {}
        
        func minimizeTapped() {
            controller?.onMinimizeTapped()
        }
        
        func closePipTapped() {
            controller?.onCloseTapped()
        }
    }
}
