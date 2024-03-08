//
//  GraphQLLiveEventLiker.swift
//  Clickmelive
//
//  Created by Can on 5.03.2024.
//

import ClickmeliveSaasAPI

final class GraphQLLiveEventLiker: GraphQLClient, LiveEventLiker {
    func like(liveEventId: String, userId: String, like: Bool, completion: @escaping (LiveEventLiker.Result) -> Void) {
        performMutation(mutation: LikeLiveEventMutation(liveEventId: liveEventId, userId: userId, like: like), mapper: LikeLiveEventMutationMapper.map, completion: completion)
    }
}
