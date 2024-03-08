//
//  LiveEventStatsChangeListener.swift
//  ClickmeliveCore
//
//  Created by Can on 2.03.2024.
//

protocol LiveEventStatsChangeListener {
    typealias Result = Swift.Result<LiveEvent, Error>

    func listen(id: String, completion: @escaping (Result) -> Void)
}
