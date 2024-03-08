//
//  LiveEventUserInteractionLoader.swift
//  ClickmeliveCore
//
//  Created by Can on 2.03.2024.
//

protocol LiveEventUserInteractionLoader {
    typealias Result = Swift.Result<LiveEventUserInteraction, Error>

    func load(liveEventId: String, userId: String, completion: @escaping (Result) -> Void)
}
