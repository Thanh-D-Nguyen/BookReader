//
//  AppState.swift
//  KinhLangNghiemMVP
//
//  Created by Nguyen Van Thanh on 2022/02/11.
//

import Foundation

class AppState: Codable {
    let transitionStyle: Int
    let currentReadingName: String
    let isOrientationLock: Bool
    let displayBrighness: Double
    let isHidePageNumber: Bool
    let isHideClock: Bool
    let pageTurnAnimation: Bool

    init() {
        self.transitionStyle = 0
        self.currentReadingName = ""
        self.isOrientationLock = true
        self.displayBrighness = 0.5
        self.isHidePageNumber = false
        self.isHideClock = true
        self.pageTurnAnimation = true
    }
    
    init(transitionStyle: Int,
         currentReadingName: String,
         isOrientationLock: Bool,
         displayBrighness: Double,
         isHidePageNumber: Bool,
         isHideClock: Bool,
         pageTurnAnimation: Bool) {
        
        self.transitionStyle = transitionStyle
        self.currentReadingName = currentReadingName
        self.isOrientationLock = isOrientationLock
        self.displayBrighness = displayBrighness
        self.isHidePageNumber = isHidePageNumber
        self.isHideClock = isHideClock
        self.pageTurnAnimation = pageTurnAnimation
    }
}

extension AppState: RealmRepresentable {
    var uid: String {
        return ""
    }
    
    func asRealm() -> RMAppState {
        let state = RMAppState()
        state.transitionStyle = transitionStyle
        state.currentReadingName = currentReadingName
        state.isOrientationLock = isOrientationLock
        state.displayBrighness = displayBrighness
        state.isHidePageNumber = isHidePageNumber
        state.isHideClock = isHideClock
        state.pageTurnAnimation = pageTurnAnimation
        return state
    }
}
