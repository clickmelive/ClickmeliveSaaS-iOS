//
//  ChatMessageCreateManagerFactory.swift
//  Clickmelive
//
//  Created by Can on 5.03.2024.
//

import Apollo

final class ChatMessageCreateManagerFactory {
    
    private init() {}
    
    static func makeManager(client: ApolloClient, output: ChatMessageCreateManagerOutput? = nil) -> ChatMessageCreateManager {
        let chatMessageCreator = GraphQLChatMessageCreator(apolloClient: client)
        let manager = ChatMessageCreateManager(chatMessageCreator: chatMessageCreator)
        manager.output = output
        return manager
    }
}
