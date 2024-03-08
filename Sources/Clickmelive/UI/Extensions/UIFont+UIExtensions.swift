//
//  UIFont+Extensions.swift
//  ClickmeliveUI
//
//  Created by Can on 3.03.2024.
//

import UIKit

extension UIFont {
    static func appFont(_ font: Fonts, size: CGFloat) -> UIFont {
        // Attempt to use the custom font
        if let customFont = UIFont(name: FontManager.getFontName(for: font), size: size) {
            return customFont
        } else {
            // Fallback to a system font
            return UIFont.systemFont(ofSize: size)
        }
    }
}
