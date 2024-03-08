//
//  UIImage+Extensions.swift
//  ClickmeliveUI
//
//  Created by Can on 3.03.2024.
//

import UIKit

extension UIImage {
    static func appImage(_ image: AppImage) -> UIImage? {
        return UIImage(named: image.rawValue, in: Bundle.module, compatibleWith: nil)
    }
}
