//
//  AppStateManagement.swift
//  KinhLangNghiemMVP
//
//  Created by Nguyen Van Thanh on 2022/02/11.
//

import Foundation

class AppStateManagement {
    static let shared = AppStateManagement()
    
    func getAppState() -> AppState {
        DispatchQueue.main.sync {
            let rState = RealmService.shared.realm.objects(RMAppState.self).first
            return rState?.asDomain() ?? AppState()
        }
    }
    
    func updateAppState(_ state: AppState?) {
        if state == nil {
            let rState = RealmService.shared.realm.objects(RMAppState.self).first
            if rState == nil {
                let appState = AppState().asRealm()
                try! RealmService.shared.realm.write({
                    RealmService.shared.realm.add(appState)
                })
            }
        } else {
            try! RealmService.shared.realm.write({
                RealmService.shared.realm.add(state!.asRealm(), update: .all)
            })
        }
    }
}
