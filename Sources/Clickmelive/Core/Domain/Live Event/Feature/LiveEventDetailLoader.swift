//
//  LiveEventDetailLoader.swift
//  ClickmeliveCore
//
//  Created by Can on 2.03.2024.
//

protocol LiveEventDetailLoader {
    typealias Result = Swift.Result<LiveEvent, Error>

    func load(id: String, completion: @escaping (Result) -> Void)
}
