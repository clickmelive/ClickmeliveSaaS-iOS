//
//  UIApplication+Extensions.swift
//  ClickmeliveUI
//
//  Created by Can on 3.03.2024.
//

import UIKit

extension UIApplication {
    static var safeAreaInsets: UIEdgeInsets  {
        return UIApplication.shared.keyWindow?.safeAreaInsets ?? .zero
    }
}
