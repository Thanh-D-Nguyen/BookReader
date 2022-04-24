//
//  Chapter.swift
//  BookReader
//
//  Created by Nguyen Van Thanh on 2022/04/10.
//

import Foundation

class Chapter: NSObject {
    var title: String = ""
    var index: Int = -1
    var locationOffset: UInt = 0
    var baseUrl: String = ""
    var text: String = ""
    var attributes: [NSRange: [HTMLAttributeItem]] = [:]
    
    var attributesText: NSAttributedString {
        
        let attText = NSMutableAttributedString(string: text)
        
        for (range, attItems) in attributes {
            print(attItems)
        }
        
        return attText
    }
}
