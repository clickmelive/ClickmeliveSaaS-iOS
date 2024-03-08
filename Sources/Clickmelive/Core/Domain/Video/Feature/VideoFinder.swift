//
//  VideoFinder.swift
//  ClickmeliveCore
//
//  Created by Can on 4.03.2024.
//

protocol VideoFinder {
    typealias Result = Swift.Result<[Video], Error>

    func find(params: CMLVideosQuery.Params ,completion: @escaping (Result) -> Void)
}
