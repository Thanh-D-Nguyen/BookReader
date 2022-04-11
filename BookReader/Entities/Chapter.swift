//
//  Chapter.swift
//  BookReader
//
//  Created by Nguyen Van Thanh on 2022/04/10.
//

import Foundation

struct Chapter {
    var title: String
    var index: Int
    var pageOffset: Int
    var baseUrl: URL?
    var pages: [Page]
}
