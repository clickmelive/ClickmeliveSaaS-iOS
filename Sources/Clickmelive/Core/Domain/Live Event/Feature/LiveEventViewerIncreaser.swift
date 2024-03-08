//
//  LiveEventViewerIncreaser.swift
//  ClickmeliveCore
//
//  Created by Can on 2.03.2024.
//

protocol LiveEventViewerIncreaser {
    typealias Result = Swift.Result<LiveEvent, Error>

    func increase(id: String, userId: String, completion: @escaping (Result) -> Void)
}

