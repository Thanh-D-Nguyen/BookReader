//
//  AppService.swift
//  eMarket
//
//  Created by Nguyen Van Thanh on 2021/11/26.
//

import Foundation

class AppService {
    class func bootstrap() {
        RealmService.shared.configuration()
    }
}
