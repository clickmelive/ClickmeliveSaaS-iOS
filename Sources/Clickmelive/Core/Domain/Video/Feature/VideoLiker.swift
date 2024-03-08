//
//  VideoLiker.swift
//  Clickmelive
//
//  Created by Can on 6.03.2024.
//

protocol VideoLiker {
    typealias Result = Swift.Result<Video, Error>

    func like(videoId: String, userId: String, like: Bool, completion: @escaping (Result) -> Void)
}
