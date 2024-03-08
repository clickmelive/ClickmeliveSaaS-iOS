//
//  String+Extensions.swift
//  ClickmeliveUI
//
//  Created by Can on 3.03.2024.
//

import UIKit

extension String {
    func stringSize(width: CGFloat, font: UIFont) -> CGSize {
        let estimateFrame = NSString(string: self).boundingRect(
            with: CGSize(width: width, height: .greatestFiniteMagnitude),
            options: .usesLineFragmentOrigin,
            attributes: [.font: font],
            context: nil).size
        
        return CGSize(width: width, height: estimateFrame.height)
    }
}
