//
//  FontManager.swift
//  ClickmeliveUI
//
//  Created by Can on 3.03.2024.
//

import UIKit

public enum Fonts: String {
    case light
    case regular
    case medium
    case bold
}

struct FontManager {
    static var light: String = Fonts.light.rawValue
    static var regular: String = Fonts.regular.rawValue
    static var medium: String = Fonts.medium.rawValue
    static var bold: String = Fonts.bold.rawValue
   
    static func setFontNames(_ fontNames: [Fonts: String]) {
        for (font, name) in fontNames {
            switch font {
            case .light:
                FontManager.light = name
            case .regular:
                FontManager.regular = name
            case .medium:
                FontManager.medium = name
            case .bold:
                FontManager.bold = name
            }
        }
    }

    static func getFontName(for font: Fonts) -> String {
        switch font {
        case .light:
            return FontManager.light
        case .regular:
            return FontManager.regular
        case .medium:
            return FontManager.medium
        case .bold:
            return FontManager.bold
        }
    }
}
