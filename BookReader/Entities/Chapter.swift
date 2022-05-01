//
//  Chapter.swift
//  BookReader
//
//  Created by Nguyen Van Thanh on 2022/04/10.
//

import UIKit

class Chapter: NSObject {
    var title: String = ""
    var index: Int = -1
    var locationOffset: Int = 0
    var baseUrl: String = ""
    var text: String = ""
    var attributes: [NSRange: [HTMLAttributeItem]] = [:]
    
    var attributesText: NSAttributedString {
        let attText = NSMutableAttributedString(string: text)
        return attText
    }
    
    override var description: String {
        return "index: \(index) baseURL: \(baseUrl)"
    }
}
