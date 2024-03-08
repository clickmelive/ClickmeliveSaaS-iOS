//
//  LiveEventStatsChangeManagerFactory.swift
//  Clickmelive
//
//  Created by Can on 5.03.2024.
//

import Apollo

final class LiveEventStatsChangeManagerFactory {
    
    private init() {}
    
    static func makeManager(client: ApolloClient, output: LiveEventStatsChangeManagerOutput? = nil) -> LiveEventStatsChangeManager {
        let liveEventStatsChangeListener = GraphQLLiveEventStateChangeListener(apolloClient: client)
        let manager = LiveEventStatsChangeManager(liveEventStatsChangeListener: liveEventStatsChangeListener)
        manager.output = output
        return manager
    }
}

