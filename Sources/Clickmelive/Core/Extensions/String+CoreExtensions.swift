//
//  String+Extensions.swift
//  ClickmeliveCore
//
//  Created by Can on 4.03.2024.
//

import Foundation

extension Optional where Wrapped == String {
    var asURL: URL? {
        guard let strongSelf = self else { return nil }
        return URL(string: strongSelf)
    }
}
