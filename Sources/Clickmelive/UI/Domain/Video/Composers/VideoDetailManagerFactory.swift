//
//  VideoDetailManagerFactory.swift
//  Clickmelive
//
//  Created by Can on 5.03.2024.
//

import Foundation
import Apollo

final class VideoDetailManagerFactory {
    
    private init() {}
    
    static func makeManager(client: ApolloClient, output: VideoDetailManagerOutput? = nil) -> VideoDetailManager {
        let videoDetailLoader = GraphQLVideoDetailLoader(apolloClient: client)
        let videoUpdateListener = GraphQLVideoUpdateListener(apolloClient: client)
        let manager = VideoDetailManager(videoDetailLoader: videoDetailLoader, videoUpdateListener: videoUpdateListener)
        manager.output = output
        return manager
    }
}
