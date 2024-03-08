//
//  GraphQLLiveEventViewerIncreaser.swift
//  Clickmelive
//
//  Created by Can on 5.03.2024.
//

import ClickmeliveSaasAPI

final class GraphQLLiveEventViewerIncreaser: GraphQLClient, LiveEventViewerIncreaser {
    func increase(id: String, userId: String, completion: @escaping (LiveEventDetailLoader.Result) -> Void) {
        performMutation(mutation: IncreaseViewerLiveEventMutation(id: id, userId: userId), mapper: IncreaseViewerLiveEventMutationMapper.map, completion: completion)
    }
}
