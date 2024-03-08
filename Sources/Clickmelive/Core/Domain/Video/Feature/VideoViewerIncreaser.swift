//
//  VideoViewerIncreaser.swift
//  Clickmelive
//
//  Created by Can on 5.03.2024.
//

public protocol VideoViewerIncreaser {
    typealias Result = Swift.Result<Video, Error>

    func increase(id: String, userId: String, completion: @escaping (Result) -> Void)
}
