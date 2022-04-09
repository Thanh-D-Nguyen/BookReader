//
//  Medium.swift
//  KinhLangNghiemMVP
//
//  Created by Nguyen Van Thanh on 2022/03/03.
//

import Foundation
    
struct Medium: Hashable {
    var mId: Int
    var youtubeUrl: String
    var image: String
    var name: String
    var localPath: String
    var videoPath: String
    var sortIndex: Int
    
    func copy() -> Medium {
        return Medium(mId: mId,
                      youtubeUrl: youtubeUrl,
                      image: image,
                      name: name,
                      localPath: localPath,
                      videoPath: videoPath,
                      sortIndex: sortIndex)
    }
}

extension Medium: RealmRepresentable {
    var uid: String {
        return youtubeUrl.lastPathComponent
    }
    
    func asRealm() -> RMMedium {
        let medium = RMMedium()
        medium.mId = mId
        medium.youtubeUrl = youtubeUrl
        medium.image = image
        medium.name =  name
        medium.localPath = localPath
        medium.videoPath = videoPath
        medium.sortIndex = sortIndex
        return medium
    }
}
