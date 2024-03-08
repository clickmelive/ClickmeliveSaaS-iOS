//
//  Int+Extensions.swift
//  ClickmeliveCore
//
//  Created by Can on 4.03.2024.
//

import Foundation

// TODO: - Add Localization if needed
extension Int {
    func toAbbreviateNumber() -> String {
        guard self > 9999 else { return "\(self)" }

        var num: Double = Double(self)
        let sign = ((num < 0) ? "-" : "" )
        num = fabs(num)

        let exp: Int = Int(log10(num) / 3.0)
        let units: [String] = ["B", "Mn", "Mr", "Tn"]

        if exp <= 0 {
            return "\(sign)\(num)"
        } else {
            let index = exp-1 < units.count ? exp-1 : units.count-1 // Ensure index does not exceed bounds
            let roundedNum = round(10 * num / pow(1000.0,Double(exp))) / 10
            let numberFormatter = NumberFormatter()
            numberFormatter.numberStyle = .decimal
            numberFormatter.maximumFractionDigits = 1
            numberFormatter.minimumFractionDigits = 0
          
            // Format the number with the locale's decimal separator, which might be a comma or a dot
            let formattedNumber = numberFormatter.string(from: NSNumber(value: roundedNum)) ?? "\(roundedNum)"
            return "\(sign)\(formattedNumber)\(units[index])"
        }
    }
}
