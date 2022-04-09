//
//  Bookmark.swift
//  KinhLangNghiemMVP
//
//  Created by Nguyen Van Thanh on 2022/01/30.
//

import Foundation

class Bookmark: Codable {
    let time: TimeInterval
    let chapterName: String
    let content: String
    let chapterIndex: Int
    let textLocation: Int
    let bookId: String
    
    init(time: TimeInterval,
         chapterName: String,
         content: String,
         chapterIndex: Int,
         textLocation: Int,
         bookId: String) {
        self.time = time
        self.chapterName = chapterName
        self.content = content
        self.chapterIndex = chapterIndex
        self.textLocation = textLocation
        self.bookId = bookId
    }
}

extension Bookmark: Equatable {
    static func == (lhs: Bookmark, rhs: Bookmark) -> Bool {
        return lhs.time == rhs.time &&
        lhs.chapterName == rhs.chapterName &&
        lhs.content == rhs.content &&
        lhs.chapterIndex == rhs.chapterIndex &&
        lhs.textLocation == rhs.textLocation &&
        lhs.bookId == rhs.bookId
    }
}
extension Bookmark: RealmRepresentable {
    var uid: String {
        return String(time)
    }
    
    func asRealm() -> RMBookmark {
        let mark = RMBookmark()
        mark.time = time
        mark.chapterName = chapterName
        mark.content = content
        mark.chapterIndex = chapterIndex
        mark.textLocation = textLocation
        mark.bookId = bookId
        return mark
    }
}
