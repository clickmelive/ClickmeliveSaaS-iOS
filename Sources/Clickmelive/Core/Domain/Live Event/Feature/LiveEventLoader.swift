//
//  LiveEventLoader.swift
//  ClickmeliveCore
//
//  Created by Can on 2.03.2024.
//

protocol LiveEventLoader {
    typealias Result = Swift.Result<[LiveEvent], Error>

    func load(completion: @escaping (Result) -> Void)
}
