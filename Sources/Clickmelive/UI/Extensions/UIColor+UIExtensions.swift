//
//  UIColor+Extensions.swift
//  ClickmeliveUI
//
//  Created by Can on 3.03.2024.
//

import UIKit

extension UIColor {
    static func appColor(_ color: AppColor) -> UIColor {
        return UIColor(named: color.rawValue, in: Bundle.module, compatibleWith: nil)!
    }
}
