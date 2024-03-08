//
//  LiveEventViewerCountLoader.swift
//  ClickmeliveCore
//
//  Created by Can on 2.03.2024.
//

protocol LiveEventViewerLoader {
    typealias Result = Swift.Result<LiveEventViewer, Error>

    func load(eventId: String, completion: @escaping (Result) -> Void)
}
