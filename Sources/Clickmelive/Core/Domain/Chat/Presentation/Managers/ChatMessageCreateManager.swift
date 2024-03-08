//
//  ChatMessageCreateManager.swift
//  Clickmelive
//
//  Created by Can on 5.03.2024.
//

import Foundation

protocol ChatMessageCreateManagerOutput {
    func messageCreated(chatMessage: ChatMessage)
}

final class ChatMessageCreateManager {
    
    var output: ChatMessageCreateManagerOutput?
    var failureOutput: FailureOutput?
    
    private let chatMessageCreator: ChatMessageCreator
    
    init(chatMessageCreator: ChatMessageCreator) {
        self.chatMessageCreator = chatMessageCreator
    }
}

extension ChatMessageCreateManager {
    func createMessage(userId: String, eventId: String, userDisplayName: String, message: String) {
        chatMessageCreator.create(userId: userId, eventId: eventId, userDisplayName: userDisplayName, message: message) { [weak self] result in
            switch result {
            case let .success(chatMessage):
                self?.output?.messageCreated(chatMessage: chatMessage)
            case let .failure(error):
                self?.failureOutput?.failed(error: error)
            }
        }
    }
}
