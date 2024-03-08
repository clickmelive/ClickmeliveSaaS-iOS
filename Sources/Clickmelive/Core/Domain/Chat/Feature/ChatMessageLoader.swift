//
//  ChatMessageLoader.swift
//  Clickmelive
//
//  Created by Can on 5.03.2024.
//

protocol ChatMessageLoader {
    typealias Result = Swift.Result<[ChatMessage], Error>

    func load(eventId: String, completion: @escaping (Result) -> Void)
}
