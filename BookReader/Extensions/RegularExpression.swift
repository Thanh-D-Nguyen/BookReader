//
//  RegularExpression.swift
//  KinhLangNghiemMVP
//
//  Created by Nguyen Van Thanh on 2022/03/15.
//

import Foundation

extension NSRegularExpression {
    func matches(_ string: String) -> Bool {
        let range = NSRange(location: 0, length: string.utf16.count)
        return firstMatch(in: string, options: [], range: range) != nil
    }
}
