//
//  WeakRef.swift
//  Clickmelive
//
//  Created by Can on 5.03.2024.
//

import Foundation

final class WeakRef<T: AnyObject> {
    weak var object: T?
    
    init(_ object: T) {
        self.object = object
    }
}
