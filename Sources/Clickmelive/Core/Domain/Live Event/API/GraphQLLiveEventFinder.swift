//
//  GraphQLLiveEventFinder.swift
//  ClickmeliveCore
//
//  Created by Can on 3.03.2024.
//

import ClickmeliveSaasAPI

final class GraphQLLiveEventFinder: GraphQLClient, LiveEventFinder {
    func find(params: CMLLiveEventsQuery.Params, completion: @escaping (LiveEventFinder.Result) -> Void) {
        let input: LiveEventSearchInput = .init(
            title: GraphQLNullable(optionalValue: params.getTitle()),
            tags: GraphQLNullable(optionalValue: params.getTags()),
            statuses: GraphQLNullable(optionalValue: params.getStatuses()),
            replayAvailable: GraphQLNullable(optionalValue: params.getReplayAvailable()),
            limit: GraphQLNullable(optionalValue: params.getLimit()),
            page: GraphQLNullable(optionalValue: params.getPage()))
        
        perform(query: SearchLiveEventsQuery(input: input), mapper: SearchLiveEventsQueryMapper.map, completion: completion)
    }
}
