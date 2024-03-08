//
//  VideoUserInteractionLoader.swift
//  Clickmelive
//
//  Created by Can on 6.03.2024.
//

protocol VideoUserInteractionLoader {
    typealias Result = Swift.Result<VideoUserInteraction, Error>

    func load(videoId: String, userId: String, completion: @escaping (Result) -> Void)
}
