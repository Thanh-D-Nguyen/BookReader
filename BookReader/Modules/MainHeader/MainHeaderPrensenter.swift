//
//  MainHeaderPrensenter.swift
//  BookReader
//
//  Created by Nguyen Van Thanh on 2022/04/09.
//

import Foundation

protocol MainHeaderPrensenterProtocol: AnyObject {
    
}

class MainHeaderPrensenter {
    private let interactor: MainHeaderInteractorProtocol
    private let router: MainHeaderRouterProtocol
    private let view: MainHeaderViewProtocol

    init(router: MainHeaderRouterProtocol,
         view: MainHeaderViewProtocol,
         interactor: MainHeaderInteractorProtocol) {
        self.router = router
        self.view = view
        self.interactor = interactor
    }
}

extension MainHeaderPrensenter: MainHeaderPrensenterProtocol {
    
}
