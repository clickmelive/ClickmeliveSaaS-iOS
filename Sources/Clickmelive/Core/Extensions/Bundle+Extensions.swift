//
//  Bundle+Extensions.swift
//  Clickmelive
//
//  Created by Can Kacmaz on 26.03.2024.
//

import Foundation

extension Bundle {
    /// Returns the resource bundle associated with the current Swift module.
    static var clickmeliveBundle: Bundle {
        let mainBundle = Bundle.main
        let bundleName = "Clickmelive_Clickmelive"

        guard let url = mainBundle.url(forResource: bundleName, withExtension: "bundle"),
              let bundle = Bundle(url: url) else {
            fatalError("Clickmelive bundle not found")
        }

        return bundle
    }
}
