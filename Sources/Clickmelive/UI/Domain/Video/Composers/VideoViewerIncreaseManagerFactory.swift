//
//  VideoViewerIncreaseManagerFactory.swift
//  Clickmelive
//
//  Created by Can on 5.03.2024.
//

import Apollo

final class VideoViewerIncreaseManagerFactory {
    
    private init() {}
    
    static func makeManager(client: ApolloClient, output: VideoViewerIncreaseManagerOutput? = nil) -> VideoViewerIncreaseManager {
        let videoViewerIncreaser = GraphQLVideoViewerIncreaser(apolloClient: client)
        let manager = VideoViewerIncreaseManager(videoViewerIncreaser: videoViewerIncreaser)
        manager.output = output
        return manager
    }
}
