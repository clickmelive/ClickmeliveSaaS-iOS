//
//  LiveEventItemLoader.swift
//  ClickmeliveCore
//
//  Created by Can on 2.03.2024.
//

protocol LiveEventItemLoader {
    typealias Result = Swift.Result<[Item], Error>

    func load(eventId: String, completion: @escaping (Result) -> Void)
}
