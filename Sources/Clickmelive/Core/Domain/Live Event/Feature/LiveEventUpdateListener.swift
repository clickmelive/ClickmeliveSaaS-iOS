//
//  LiveEventUpdateListener.swift
//  ClickmeliveCore
//
//  Created by Can on 2.03.2024.
//

protocol LiveEventUpdateListener {
    typealias Result = Swift.Result<LiveEvent, Error>

    func listen(id: String, completion: @escaping (Result) -> Void)
}
