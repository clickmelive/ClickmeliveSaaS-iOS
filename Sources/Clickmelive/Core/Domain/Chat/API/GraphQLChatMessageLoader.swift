//
//  GraphQLChatMessageLoader.swift
//  Clickmelive
//
//  Created by Can on 5.03.2024.
//

import ClickmeliveSaasAPI

final class GraphQLChatMessageLoader: GraphQLClient, ChatMessageLoader {
    func load(eventId: String, completion: @escaping (ChatMessageLoader.Result) -> Void) {
        perform(query: GetChatRoomContentByEventIdQuery(eventId: eventId, nextToken: nil), mapper: GetChatRoomContentByEventIdQueryMapper.map, completion: completion)
    }
}
