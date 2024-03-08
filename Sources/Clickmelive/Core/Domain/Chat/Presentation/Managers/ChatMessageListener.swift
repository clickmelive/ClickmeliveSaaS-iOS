//
//  ChatMessageListener.swift
//  Clickmelive
//
//  Created by Can on 5.03.2024.
//

protocol ChatMessageListener {
    typealias Result = Swift.Result<ChatMessage, Error>

    func listen(eventId: String, completion: @escaping (Result) -> Void)
}
