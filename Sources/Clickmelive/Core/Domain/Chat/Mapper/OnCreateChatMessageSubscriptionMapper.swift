//
//  OnCreateChatMessageSubscriptionMapper.swift
//  Clickmelive
//
//  Created by Can on 5.03.2024.
//

import ClickmeliveSaasAPI

struct OnCreateChatMessageSubscriptionMapper {
    static func map(data: OnCreateChatMessageSubscription.Data?) -> Result<ChatMessage, Error> {
        guard let data = data else {
            return .failure(GraphQLMapperError.noDataReceived)
        }

        guard let chatMessagesData = data.onCreateChatMessage else {
            return .failure(GraphQLMapperError.dataMissing)
        }

        let chatMessage = chatMessagesData.fragments.chatMessageGQL.toChatMessage
        
        return .success(chatMessage)
    }
}
