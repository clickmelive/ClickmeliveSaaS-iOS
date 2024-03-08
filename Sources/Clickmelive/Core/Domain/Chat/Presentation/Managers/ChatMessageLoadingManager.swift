//
//  ChatMessageLoadingManager.swift
//  Clickmelive
//
//  Created by Can on 5.03.2024.
//

import Foundation

protocol ChatMessageLoadingManagerOutput {
    func chatMessagesLoaded(messages: [ChatMessage])
}

final class ChatMessageLoadingManager {
    
    var output: ChatMessageLoadingManagerOutput?
    var failureOutput: FailureOutput?
    
    private let chatMessageLoader: ChatMessageLoader
    private let chatMessageListener: ChatMessageListener
    
    init(chatMessageLoader: ChatMessageLoader,
                chatMessageListener: ChatMessageListener) {
        self.chatMessageLoader = chatMessageLoader
        self.chatMessageListener = chatMessageListener
    }
    
    private var maxMessageCount: Int { return 20 }
    private var messagesQueue = Queue<ChatMessage>()
}

extension ChatMessageLoadingManager {
    func load(eventId: String) {
        chatMessageLoader.load(eventId: eventId) { [weak self] result in
            switch result {
            case let .success(chatMessages):
                chatMessages.forEach {
                    self?.addMessageToFixedArray(message: $0)
                }
            case let .failure(error):
                self?.failureOutput?.failed(error: error)
            }
        }
    }
}

extension ChatMessageLoadingManager {
    func listen(eventId: String) {
        chatMessageListener.listen(eventId: eventId) { [weak self] result in
            switch result {
            case let .success(chatMessage):
                self?.addMessageToFixedArray(message: chatMessage)
            case let .failure(error):
                self?.failureOutput?.failed(error: error)
            }
        }
    }
}

extension ChatMessageLoadingManager {
    private func addMessageToFixedArray(message: ChatMessage) {
        if messagesQueue.elements.count > maxMessageCount {
            messagesQueue.dequeue()
        }
        messagesQueue.enqueue(message)
        output?.chatMessagesLoaded(messages: messagesQueue.elements.reversed())
    }
}

