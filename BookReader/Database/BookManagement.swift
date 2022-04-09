//
//  BookManagement.swift
//  KinhLangNghiemVIP
//
//  Created by Nguyen Van Thanh on 2022/01/16.
//

import Foundation

class BookManagement {
    static let shared = BookManagement()
    
    func getAll() -> [Book] {
        let books = RealmService.shared.realm.objects(RMBook.self)
        return books.map({ $0.asDomain() })
    }
    
    func getBook(_ bookId: String) -> Book? {
        DispatchQueue.main.sync {
            return getAll().first(where: { $0.uid == bookId })
        }
    }
    
    func addBooks(_ books: [Book]) {
        let saveItems = books.map({ $0.asRealm() })
        try! RealmService.shared.realm.write({
            RealmService.shared.realm.add(saveItems, update: .error)
        })
    }
    
    func updateReadingTime(_ readingTime: Int, ofBook bookId: String) {
        let book = getBook(bookId)?.asRealm()
        try! RealmService.shared.realm.write({
            book?.readingTime = readingTime
        })
    }
}
