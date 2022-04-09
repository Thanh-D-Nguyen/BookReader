//
//  Enums.swift
//  KinhLangNghiemMVP
//
//  Created by Nguyen Van Thanh on 2022/02/11.
//

import Foundation
import UIKit

enum ReadingPageColorStyle: Int {
    case light
    case harmony
    case dark1
    case dark2
    
    var textColor: UIColor {
        switch self {
        case .light:
            return UIColor(rgb: 0xF8F8F8)
        case .harmony:
            return UIColor(rgb: 0xE9E6D7)
        case .dark1:
            return UIColor(rgb: 0x373737)
        case .dark2:
            return UIColor(rgb: 0x000000)
        }
    }
    
    var separatorColor: UIColor {
        return UIColor(white: 1, alpha: 0.08)
    }
    
    var backgroundColor: UIColor? {
        switch self {
        case .light:
            return UIColor(rgb: 0xFFFFFF)
        case .harmony:
            return UIColor(rgb: 0xFDF9EA)
        case .dark1:
            return UIColor(rgb: 0x454545)
        case .dark2:
            return UIColor(rgb: 0x282828)
        }
    }
    
    var statusBarStyle: UIStatusBarStyle {
        if self == .light || self == .harmony {
            return .default
        }
        return .lightContent
    }
    
    var barStyle: UIBarStyle {
        if self == .light || self == .harmony {
            return .default
        }
        return .black
    }
}

enum AvailableFont: String {
    case TimesNewRoman = "TimesNewRomanPSMT"
    case American = "AmericanTypewriter"
    case Georgia = "Georgia"
    case Palatino = "Palatino-Roman"
    
    func fontWithSize(_ size: CGFloat) -> UIFont {
        return UIFont(name: self.rawValue, size: size) ?? UIFont.systemFont(ofSize: size)
    }
}

enum PageTransistionStyle: Int {
    case curl
    case scroll
}
