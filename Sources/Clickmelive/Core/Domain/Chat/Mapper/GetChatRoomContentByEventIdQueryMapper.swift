//
//  GetChatRoomContentByEventIdQueryMapper.swift
//  Clickmelive
//
//  Created by Can on 5.03.2024.
//

import ClickmeliveSaasAPI

struct GetChatRoomContentByEventIdQueryMapper {
    static func map(data: GetChatRoomContentByEventIdQuery.Data?) -> Result<[ChatMessage], Error> {
        guard let data = data else {
            return .failure(GraphQLMapperError.noDataReceived)
        }

        guard let chatMessagesData = data.getChatRoomContentByEventId else {
            return .failure(GraphQLMapperError.dataMissing)
        }

        let chatMessages = chatMessagesData.messages?.compactMap {$0}.compactMap {
            $0.fragments.chatMessageGQL.toChatMessage
        } ?? []
        
        return .success(chatMessages)
    }
}
