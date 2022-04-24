//
//  Page.swift
//  BookReader
//
//  Created by Nguyen Van Thanh on 2022/04/10.
//

import Foundation

struct Page {
    var range: NSRange
    var index: Int
    var startLocation: Int
    var endLocation: Int
    var content: NSAttributedString
}
