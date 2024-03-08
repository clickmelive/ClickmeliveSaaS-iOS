//
//  VideoStatsChangeManagerFactory.swift
//  Clickmelive
//
//  Created by Can on 5.03.2024.
//

import Apollo

final class VideoStatsChangeManagerFactory {
    
    private init() {}
    
    static func makeManager(client: ApolloClient, output: VideoStatsChangeManagerOutput? = nil) -> VideoStatsChangeManager {
        let videoStatsChangeListener = GraphQLVideoStateChangeListener(apolloClient: client)
        let manager = VideoStatsChangeManager(videoStatsChangeListener: videoStatsChangeListener)
        manager.output = output
        return manager
    }
}
