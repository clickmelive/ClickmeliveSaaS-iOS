//
//  LiveEventUserInteractionManagerFactory.swift
//  Clickmelive
//
//  Created by Can on 5.03.2024.
//

import Apollo

final class LiveEventUserInteractionManagerFactory {
    
    private init() {}
    
    static func makeManager(client: ApolloClient, output: LiveEventUserInteractionManagerOutput? = nil) -> LiveEventUserInteractionManager {
        let liveEventUserInteractionLoader = GraphQLLiveEventUserInteractionLoader(apolloClient: client)
        let manager = LiveEventUserInteractionManager(liveEventUserInteractionLoader: liveEventUserInteractionLoader)
        manager.output = output
        return manager
    }
}
