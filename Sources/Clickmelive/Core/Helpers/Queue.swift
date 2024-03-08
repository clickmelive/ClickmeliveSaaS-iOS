//
//  Queue.swift
//  Clickmelive
//
//  Created by Can on 5.03.2024.
//

import Foundation

struct Queue<T> {
    var elements: [T] = []

    mutating func enqueue(_ value: T) {
        elements.append(value)
    }

    @discardableResult
    mutating func dequeue() -> T? {
        guard !elements.isEmpty else {
            return nil
        }
        return elements.removeFirst()
    }

    var head: T? {
        return elements.first
    }

    var tail: T? {
        return elements.last
    }
}
