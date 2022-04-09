//
//  RealmService.swift
//  FlashCard
//
//  Created by Nguyen Van Thanh on 2021/04/03.
//

import RealmSwift
import Foundation

class RealmService {
    private let databaseName = "book_reader.db"
    private let databaseVersion: UInt64 = 001
    static let shared = RealmService()
    var realm: Realm!
    
    init() { }
    
    func configuration() {
        let url = Constants.inLibrarayFolder(fileName: databaseName)
        let configuration = Realm.Configuration(fileURL: url,
                                                schemaVersion: databaseVersion,
                                                migrationBlock: RealmService.migrate)
        print(url)
        do {
            realm = try Realm(configuration: configuration)
            Realm.Configuration.defaultConfiguration = configuration
        } catch {
            fatalError("Database initial error!")
        }
        parserJSON(file: "books", classObj: RMBook.self)
        parserJSON(file: "media", classObj: RMMedium.self)
    }
    
    private func parserJSON(file: String, classObj: Object.Type) {
        if let path = Bundle.main.path(forResource: file, ofType: "json") {
            do {
                let data = try Data(contentsOf: URL(fileURLWithPath: path), options: .mappedIfSafe)
                let jsonResult = try JSONSerialization.jsonObject(with: data, options: .mutableContainers)
                if realm.objects(classObj.self).count == 0 {
                    try realm.write {
                    for item in jsonResult as! Array<Any> {
                            realm.create(classObj.self, value: item, update: .error)
                        }
                    }
                }
            } catch {
                // handle error
            }
        }
    }
    
    static func migrate(migration: Migration, oldVersion: UInt64) {

    }
}
