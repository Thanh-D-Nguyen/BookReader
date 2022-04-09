//
//  LoadingInteractor.swift
//  eMarket
//
//  Created by Nguyen Van Thanh on 2021/11/26.
//

import Foundation

protocol LoadingInteractorProtocol: AnyObject {
    var didReadyToStart: (() -> Void)? { get set }
    func initialData()
}

class LoadingInteractor {
    var didReadyToStart: (() -> Void)?

}

extension LoadingInteractor: LoadingInteractorProtocol {
    func initialData() {
        //Example: get Client config
        // check server status ...
        didReadyToStart?()
    }
}
