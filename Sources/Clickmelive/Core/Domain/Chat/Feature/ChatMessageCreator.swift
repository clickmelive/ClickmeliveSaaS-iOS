//
//  ChatMessageCreator.swift
//  Clickmelive
//
//  Created by Can on 5.03.2024.
//

protocol ChatMessageCreator {
    typealias Result = Swift.Result<ChatMessage, Error>

    func create(userId: String, eventId: String, userDisplayName: String, message: String, completion: @escaping (Result) -> Void)
}
