//
//  VideoStatsChangeListener.swift
//  Clickmelive
//
//  Created by Can on 5.03.2024.
//

protocol VideoStatsChangeListener {
    typealias Result = Swift.Result<Video, Error>

    func listen(id: String, completion: @escaping (Result) -> Void)
}
