//
//  VideoLikeManagerFactory.swift
//  Clickmelive
//
//  Created by Can on 6.03.2024.
//

import Apollo

final class VideoLikeManagerFactory {
    func makeManager(client: ApolloClient, output: VideoLikeManagerOutput? = nil) -> VideoLikeManager {
        let videoLiker = GraphQLVideoLiker(apolloClient: client)
        let manager = VideoLikeManager(videoLiker: videoLiker)
        manager.output = output
        return manager
    }
}
