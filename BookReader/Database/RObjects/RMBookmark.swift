//
//  RMBookmark.swift
//  KinhLangNghiemMVP
//
//  Created by Nguyen Van Thanh on 2022/02/11.
//

import RealmSwift
import Realm

class RMBookmark: Object {
    @objc dynamic var time: TimeInterval = 0
    @objc dynamic var bookId: String = ""
    @objc dynamic var chapterName: String = ""
    @objc dynamic var content: String = ""
    @objc dynamic var chapterIndex: Int = 0
    @objc dynamic var textLocation: Int = 0
    
    override class func primaryKey() -> String? {
        return "bookId"
    }
}

extension RMBookmark: DomainConvertibleType {
    func asDomain() -> Bookmark {
        return Bookmark(time: time, chapterName: chapterName, content: content, chapterIndex: chapterIndex, textLocation: textLocation, bookId: bookId)
    }
}

