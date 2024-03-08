//
//  LiveEventViewerIncreaseManagerFactory.swift
//  Clickmelive
//
//  Created by Can on 5.03.2024.
//

import Foundation
import Apollo

final class LiveEventViewerIncreaseManagerFactory {
    
    private init() {}
   
    static func makeManager(client: ApolloClient, output: LiveEventViewerIncreaseManagerOutput? = nil) -> LiveEventViewerIncreaseManager {
        let liveEventViewerIncreaser = GraphQLLiveEventViewerIncreaser(apolloClient: client)
        let manager = LiveEventViewerIncreaseManager(liveEventViewerIncreaser: liveEventViewerIncreaser)
        manager.output = output
        return manager
    }
}
