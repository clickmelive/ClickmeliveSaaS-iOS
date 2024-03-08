//
//  LiveEventDetailManagerFactory.swift
//  Clickmelive
//
//  Created by Can on 5.03.2024.
//

import Apollo

final class LiveEventDetailManagerFactory {
    
    private init() {}
    
    static func makeManager(client: ApolloClient, output: LiveEventDetailManagerOutput? = nil) -> LiveEventDetailManager {
        let liveEventDetailLoader = GraphQLLiveEventDetailLoader(apolloClient: client)
        let liveEventUpdateListener = GraphQLLiveEventUpdateListener(apolloClient: client)
        let manager = LiveEventDetailManager(liveEventDetailLoader: liveEventDetailLoader, liveEventUpdateListener: liveEventUpdateListener)
        manager.output = output
        return manager
    }
}
