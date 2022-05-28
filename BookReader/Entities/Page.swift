//
//  Page.swift
//  BookReader
//
//  Created by Nguyen Van Thanh on 2022/04/10.
//

import Foundation

struct Page {
    var range: NSRange
    var content: NSAttributedString
    var chapterOffset: Int
    var totalLocation: Int
    
    var locationInfoText: String {
        return Utils.formatLocation(chapterOffset + range.location, total: totalLocation)
    }
}
