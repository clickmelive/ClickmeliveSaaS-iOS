//
//  ChatMessageGQL+DomainConversion.swift
//  Clickmelive
//
//  Created by Can on 5.03.2024.
//

import ClickmeliveSaasAPI
import Foundation

extension ChatMessageGQL {
    var toChatMessage: ChatMessage {
        return .init(id: id, eventId: eventId, userId: userId, userDisplayName: userDisplayName, message: message)
    }
}
