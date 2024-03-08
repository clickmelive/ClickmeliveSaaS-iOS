//
//  LiveEventLiker.swift
//  ClickmeliveCore
//
//  Created by Can on 2.03.2024.
//

protocol LiveEventLiker {
    typealias Result = Swift.Result<LiveEvent, Error>

    func like(liveEventId: String, userId: String, like: Bool, completion: @escaping (Result) -> Void)
}
