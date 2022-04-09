//
//  RMAppState.swift
//  KinhLangNghiemMVP
//
//  Created by Nguyen Van Thanh on 2022/02/11.
//
import RealmSwift
import Realm

class RMAppState: Object {
    @objc dynamic var transitionStyle: Int = 0
    @objc dynamic var currentReadingName: String = ""
    @objc dynamic var isOrientationLock: Bool = true
    @objc dynamic var displayBrighness: Double = 0.5
    
    @objc dynamic var isHidePageNumber: Bool = false
    @objc dynamic var isHideClock: Bool = true
    @objc dynamic var pageTurnAnimation: Bool = true
}

extension RMAppState: DomainConvertibleType {
    func asDomain() -> AppState {
        return AppState(transitionStyle: transitionStyle,
                        currentReadingName: currentReadingName,
                        isOrientationLock: isOrientationLock,
                        displayBrighness: displayBrighness,
                        isHidePageNumber: isHidePageNumber,
                        isHideClock: isHideClock,
                        pageTurnAnimation: pageTurnAnimation)
    }
}
