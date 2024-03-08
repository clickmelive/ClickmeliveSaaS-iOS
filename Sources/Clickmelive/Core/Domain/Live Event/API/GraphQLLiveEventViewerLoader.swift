//
//  GraphQLLiveEventViewerCountLoader.swift
//  Clickmelive
//
//  Created by Can on 5.03.2024.
//

import ClickmeliveSaasAPI

final class GraphQLLiveEventViewerLoader: GraphQLClient, LiveEventViewerLoader {
    func load(eventId: String, completion: @escaping (LiveEventViewerLoader.Result) -> Void) {
        perform(query: GetLiveViewerCountQuery(id: eventId), mapper: GetLiveViewerCountQueryMapper.map, completion: completion)
    }
}
