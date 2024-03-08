//
//  VideoUserInteractionManagerFactory.swift
//  Clickmelive
//
//  Created by Can on 6.03.2024.
//

import Apollo

final class VideoUserInteractionManagerFactory {
    
    private init() {}
    
    static func makeManager(client: ApolloClient, output: VideoUserInteractionManagerOutput? = nil) -> VideoUserInteractionManager {
        let videoUserInteractionLoader = GraphQLVideoUserInteractionLoader(apolloClient: client)
        let manager = VideoUserInteractionManager(videoUserInteractionLoader: videoUserInteractionLoader)
        manager.output = output
        return manager
    }
}
