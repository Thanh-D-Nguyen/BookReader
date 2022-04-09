//
//  Number.swift
//  KinhLangNghiemMVP
//
//  Created by Nguyen Van Thanh on 2022/03/07.
//

import UIKit

extension Float {
    func formatTime(style: DateComponentsFormatter.UnitsStyle = .positional) -> String {
        let formatter = DateComponentsFormatter()
        formatter.allowedUnits = [.hour, .minute, .second]
        formatter.unitsStyle = style
        formatter.collapsesLargestUnit = false
        return formatter.string(from: Double(self)) ?? ""
    }
}

extension TimeInterval {
    func stringFromTimeInterval() -> String {
        let time = NSInteger(self)
        let seconds = time % 60
        var minutes = (time / 60) % 60
        minutes += Int(time / 3600) * 60  // to account for the hours as minutes
        return String(format: "%0.2d:%0.2d",minutes,seconds)
    }
    
}
