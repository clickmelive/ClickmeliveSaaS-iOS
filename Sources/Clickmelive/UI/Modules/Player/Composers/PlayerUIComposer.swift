//
//  PlayerUIComposer.swift
//  ClickmeliveUI
//
//  Created by Can on 4.03.2024.
//

import Foundation
import UIKit

final class PlayerUIComposer {
    private init() {}
    
    static func makeLiveEventPlayerViewController(id: String,
                                                  username: String,
                                                  onItemsTapped: @escaping ([Item], PlayerViewController?) -> Void) -> PlayerViewController {
        
        let apolloClient = CMLApolloClient.shared.apollo
        let userDefaults = CMLUserDefaults()
        let imageLoader = SDWebImageLoader()
        
        let controller = PlayerViewController()
        
        let liveEventDetailManagerOutput = LiveEventDetailManagerOutputHandler(
            controller: controller,
            imageLoader: imageLoader
        )
        
        let liveEventDetailManager = LiveEventDetailManagerFactory.makeManager(
            client: apolloClient,
            output: liveEventDetailManagerOutput
        )
        
        let liveEventStatsChangeManagerOutput = LiveEventStatsChangeManagerOutputHandler(
            controller: controller
        )
        
        let liveEventStatsChangeManager = LiveEventStatsChangeManagerFactory.makeManager(
            client: apolloClient,
            output: liveEventStatsChangeManagerOutput
        )
        
        let liveEventViewerIncreaseManager = LiveEventViewerIncreaseManagerFactory.makeManager(
            client: apolloClient
        )
        
        let liveEventUserInteractionManagerOutput = LiveEventUserInteractionManagerOutputHandler(
            controller: controller
        )
        
        let liveEventUserInteractionManager = LiveEventUserInteractionManagerFactory.makeManager(
            client: apolloClient,
            output: liveEventUserInteractionManagerOutput
        )
        
        let liveEventLikeManagerOutput = LiveEventLikeManagerOutputHandler(
            controller: controller,
            userId: userDefaults.userId
        )
        
        let liveEventLikeManager = LiveEventLikeManagerFactory.makeManager(
            client: apolloClient,
            output: liveEventLikeManagerOutput
        )
        
        let liveEventViewerCountManagerOutput = LiveEventViewerManagerOutputHandler(
            controller: controller
        )
        
        let liveEventViewerCountManager = LiveEventViewerManagerFactory.makeManager(
            client: apolloClient,
            output: liveEventViewerCountManagerOutput
        )
        
        let chatMessageCreateManager = ChatMessageCreateManagerFactory.makeManager(
            client: apolloClient
        )
        
        let chatMessageLoadingManagerOutput = ChatMessageLoadingManagerOutputHandler(
            controller: controller
        )
        
        let chatLoadingManager = ChatMessageLoadingManagerFactory.makeManager(
            client: apolloClient,
            output: chatMessageLoadingManagerOutput
        )
        
        let playerViewControllerOutputHandler = LiveEventPlayerViewControllerOutputHandler(
            controller: controller,
            eventId: id,
            userId: userDefaults.userId, 
            username: username,
            liveEventDetailManager: liveEventDetailManager,
            liveEventLikeManager: liveEventLikeManager,
            chatMessageCreateManager: chatMessageCreateManager,
            onItemsTapped: { [weak controller] items in
                onItemsTapped(items, controller)
            }
        )
        
        controller.output = playerViewControllerOutputHandler
        
        controller.onViewDidLoad { [weak controller] in
            controller?.onShouldUpdateLiveEventViewerCount = {
                liveEventViewerCountManager.loadViewerCount(eventId: id)
            }
           
            liveEventDetailManager.listen(id: id)
            chatLoadingManager.listen(eventId: id)
            chatLoadingManager.load(eventId: id)
            liveEventStatsChangeManager.listenLiveEventStats(id: id)
            liveEventDetailManager.loadEventDetail(id: id)
            liveEventViewerIncreaseManager.increaseLiveEventViewer(id: id, userId: userDefaults.userId)
            liveEventUserInteractionManager.loadLiveEventUserInteraction(liveEventId: id, userId: userDefaults.userId)
        }
        
        return controller
    }
    
    static func makeVideoPlayerViewController(id: String,
                                              onItemsTapped: @escaping ([Item], PlayerViewController?) -> Void) -> PlayerViewController {
        
        let apolloClient = CMLApolloClient.shared.apollo
        let userDefaults = CMLUserDefaults()
        let imageLoader = SDWebImageLoader()
        
        let controller = PlayerViewController()
        
        let videoDetailManagerOutput = VideoDetailManagerOutputHandler(
            controller: controller,
            imageLoader: imageLoader
        )
        
        let videoDetailManager = VideoDetailManagerFactory.makeManager(
            client: apolloClient,
            output: videoDetailManagerOutput
        )
        
        let videoStatsChangeManagerOutput = VideoStatsChangeManagerOutputHandler(
            controller: controller,
            imageLoader: imageLoader
        )
        
        let videoStatsChangeManager = VideoStatsChangeManagerFactory.makeManager(
            client: apolloClient,
            output: videoStatsChangeManagerOutput
        )
        
        let videoViewerIncreaseManager = VideoViewerIncreaseManagerFactory.makeManager(
            client: apolloClient
        )
        
        let videoUserInteractionManagerOutput = VideoUserInteractionManagerOutputHandler(
            controller: controller
        )
        
        let videoUserInteractionManager = VideoUserInteractionManagerFactory.makeManager(
            client: apolloClient,
            output: videoUserInteractionManagerOutput
        )
        
        let videoLikeManagerOutput = VideoLikeManagerOutputHandler(
            controller: controller,
            userId: userDefaults.userId
        )
        
        let videoLikeManager = VideoLikeManagerFactory().makeManager(
            client: apolloClient,
            output: videoLikeManagerOutput
        )
        
        let playerViewControllerOutputHandler = VideoPlayerViewControllerOutputHandler(
            controller: controller,
            videoId: id,
            userId: userDefaults.userId,
            videoDetailManager: videoDetailManager,
            videoLikeManager: videoLikeManager,
            onItemsTapped: { [weak controller] items in
                onItemsTapped(items, controller)
            }
        )
        
        controller.output = playerViewControllerOutputHandler
        
        controller.onViewDidLoad {
            videoDetailManager.listen(id: id)
            videoStatsChangeManager.listenVideoStats(id: id)
            videoDetailManager.loadVideo(id: id)
            videoViewerIncreaseManager.increaseVideoViewer(id: id, userId: userDefaults.userId)
            videoUserInteractionManager.loadVideoUserInteraction(videoId: id, userId: userDefaults.userId)
        }
        
        return controller
    }
}
