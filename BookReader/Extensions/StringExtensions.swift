//
//  StringExtensions.swift
//  eMarket
//
//  Created by Nguyen Van Thanh on 2021/11/28.
//

import Foundation

extension String {
    func formatTime() -> String {
        let formater = DateFormatter()
        formater.timeZone = TimeZone.init(identifier: "UTC")
        formater.dateFormat = "HH:mm:ss.SSSZ"
        let date = formater.date(from: self)
        formater.dateFormat = "HH:mm"
        let formated = formater.string(from: date ?? Date())
        return formated
    }
}
