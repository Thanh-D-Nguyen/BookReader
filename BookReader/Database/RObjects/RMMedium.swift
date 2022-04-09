//
//  RMMedium.swift
//  KinhLangNghiemMVP
//
//  Created by Nguyen Van Thanh on 2022/03/03.
//

import RealmSwift
import Realm

class RMMedium: Object {
    @objc dynamic var mId: Int = 0
    @objc dynamic var youtubeUrl: String = ""
    @objc dynamic var image: String = ""
    @objc dynamic var name: String = ""
    @objc dynamic var localPath: String = ""
    @objc dynamic var videoPath: String = ""
    @objc dynamic var sortIndex = 0
    
    override class func primaryKey() -> String? {
        return "mId"
    }
}

extension RMMedium: DomainConvertibleType {
    func asDomain() -> Medium {
        return Medium(mId: mId,
                      youtubeUrl: youtubeUrl,
                      image: image,
                      name: name,
                      localPath: localPath,
                      videoPath: videoPath,
                      sortIndex: sortIndex)
    }
}
