//
//  MediumManangement.swift
//  KinhLangNghiemMVP
//
//  Created by Nguyen Van Thanh on 2022/03/03.
//

import Foundation

class MediumManangement {
    static let shared = MediumManangement()
    
    func getAll() -> [Medium] {
        let media = RealmService.shared.realm.objects(RMMedium.self)
        return media.map({ $0.asDomain() })
    }
    
    func update(_ media: [Medium]) {
        let saveItems = media.map({ $0.asRealm() })
        try! RealmService.shared.realm.write({
            RealmService.shared.realm.add(saveItems, update: .modified)
        })
    }
}
