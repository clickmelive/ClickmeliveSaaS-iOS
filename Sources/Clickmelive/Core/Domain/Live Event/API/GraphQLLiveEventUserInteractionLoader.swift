//
//  GraphQLLiveEventUserInteractionLoader.swift
//  Clickmelive
//
//  Created by Can on 5.03.2024.
//

import ClickmeliveSaasAPI

final class GraphQLLiveEventUserInteractionLoader: GraphQLClient, LiveEventUserInteractionLoader {
    func load(liveEventId: String, userId: String, completion: @escaping (LiveEventUserInteractionLoader.Result) -> Void) {
        perform(query: GetUserInteractionLiveEventQuery(id: liveEventId, userId: userId), mapper: GetUserInteractionForLiveEventQueryMapper.map, completion: completion)
    }
}
