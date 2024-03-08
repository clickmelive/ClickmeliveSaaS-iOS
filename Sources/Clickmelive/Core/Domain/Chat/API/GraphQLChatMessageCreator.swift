//
//  GraphQLChatMessageCreator.swift
//  Clickmelive
//
//  Created by Can on 5.03.2024.
//

import ClickmeliveSaasAPI

final class GraphQLChatMessageCreator: GraphQLClient, ChatMessageCreator {
    func create(userId: String, eventId: String, userDisplayName: String, message: String, completion: @escaping (ChatMessageCreator.Result) -> Void) {
        
        performMutation(mutation: CreateChatMessageMutation(input: ChatMessageInput(userId: userId, eventId: eventId, userDisplayName: userDisplayName, message: message)), mapper: CreateChatMessageMutationMapper.map, completion: completion)
    }
}
