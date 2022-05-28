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
    
    override var description: String {
        return title + " - index \(index) - offset \(locationOffset)" + baseUrl
    }
}
