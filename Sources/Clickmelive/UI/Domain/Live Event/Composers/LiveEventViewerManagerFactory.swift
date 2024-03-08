//
//  LiveEventViewerManagerFactory.swift
//  Clickmelive
//
//  Created by Can on 5.03.2024.
//

import Apollo

final class LiveEventViewerManagerFactory {
    
    private init() {}
    
    static func makeManager(client: ApolloClient, output: LiveEventViewerManagerOutput? = nil) -> LiveEventViewerManager {
        let liveEventViewerLoader = GraphQLLiveEventViewerLoader(apolloClient: client)
        let manager = LiveEventViewerManager(liveEventViewerLoader: liveEventViewerLoader)
        manager.output = output
        return manager
    }
}

