//
//  CreateChatMessageMutationMapper.swift
//  Clickmelive
//
//  Created by Can on 5.03.2024.
//

import ClickmeliveSaasAPI

struct CreateChatMessageMutationMapper {
    static func map(data: CreateChatMessageMutation.Data?) -> Result<ChatMessage, Error> {
        guard let data = data else {
            return .failure(GraphQLMapperError.noDataReceived)
        }

        guard let chatMessagesData = data.createChatMessage else {
            return .failure(GraphQLMapperError.dataMissing)
        }

        let chatMessage = chatMessagesData.fragments.chatMessageGQL.toChatMessage
        
        return .success(chatMessage)
    }
}

