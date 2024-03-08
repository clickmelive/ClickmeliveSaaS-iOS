//
//  LiveEventLikeManagerFactory.swift
//  Clickmelive
//
//  Created by Can on 5.03.2024.
//

import Apollo

final class LiveEventLikeManagerFactory {
    
    private init() {}
    
    static func makeManager(client: ApolloClient, output: LiveEventLikeManagerOutput? = nil) -> LiveEventLikeManager {
        let liveEventLiker = GraphQLLiveEventLiker(apolloClient: client)
        let manager = LiveEventLikeManager(liveEventLiker: liveEventLiker)
        manager.output = output
        return manager
    }
}
