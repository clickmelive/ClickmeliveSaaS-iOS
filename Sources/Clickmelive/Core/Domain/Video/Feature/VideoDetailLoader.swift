//
//  VideoDetailLoader.swift
//  Clickmelive
//
//  Created by Can on 5.03.2024.
//

protocol VideoDetailLoader {
    typealias Result = Swift.Result<Video, Error>

    func load(id: String, completion: @escaping (Result) -> Void)
}
