//
//  BookmarkManagement.swift
//  KinhLangNghiemMVP
//
//  Created by Nguyen Van Thanh on 2022/02/11.
//

import Foundation

class BookmarkManagement {
    
    static let shared = BookManagement()
    
    func insert(_ bookmark: Bookmark) {
        let rMark = bookmark.asRealm()
        try! RealmService.shared.realm.write({
            RealmService.shared.realm.add(rMark, update: .error)
        })
    }
    
    func delete(_ bookmark: Bookmark) {
        let rMark = bookmark.asRealm()
        try! RealmService.shared.realm.write({
            RealmService.shared.realm.delete(rMark)
        })
    }
    
    func getAll() -> [Bookmark] {
        return RealmService.shared.realm.objects(RMBookmark.self)
            .map({ $0.asDomain() })
    }
}
