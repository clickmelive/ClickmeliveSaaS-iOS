//
//  ChatMessageLoadingManagerFactory.swift
//  Clickmelive
//
//  Created by Can on 5.03.2024.
//

import Apollo

final class ChatMessageLoadingManagerFactory {
    
    private init() {}
    
    static func makeManager(client: ApolloClient, output: ChatMessageLoadingManagerOutput? = nil) -> ChatMessageLoadingManager {
        let chatMessageLoader = GraphQLChatMessageLoader(apolloClient: client)
        let chatMessageListener = GraphQLChatMessageListener(apolloClient: client)
        let manager = ChatMessageLoadingManager(chatMessageLoader: chatMessageLoader, chatMessageListener: chatMessageListener)
        manager.output = output
        return manager
    }
}
