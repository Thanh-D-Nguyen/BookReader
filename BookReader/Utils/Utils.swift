//
//  Utils.swift
//  KinhLangNghiemMVP
//
//  Created by Nguyen Van Thanh on 2022/02/18.
//

import UIKit

class Utils {
    class func localizableText(_ key: String) -> String {
        return NSLocalizedString(key, comment: "")
    }
    
    class func formatPercentageNumber(_ number: Float) -> String {
        let formatter = NumberFormatter()
        formatter.numberStyle = .percent
        formatter.maximumFractionDigits = 2
        formatter.minimumFractionDigits = 2
        return formatter.string(from: NSNumber(value: number)) ?? "N/A"
    }
    
    class func formatLocation(_ location: Int, total: Int) -> String {
        if total == 0 { return "" }
        let formatter = NumberFormatter()
        formatter.numberStyle = .percent
        formatter.maximumFractionDigits = 2
        formatter.minimumFractionDigits = 0
        let dLoc = Int(location / 100)
        let dTotalLoc = Int(total / 100)
        return "Loc \(dLoc) / \(dTotalLoc) " + (formatter.string(from: NSNumber(value: CGFloat(location) / CGFloat(total))) ?? "0%")
    }
}
