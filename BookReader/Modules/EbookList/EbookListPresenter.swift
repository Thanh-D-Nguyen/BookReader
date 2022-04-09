//
//  EbookListPresenter.swift
//  BookReader
//
//  Created by Nguyen Van Thanh on 2022/04/09.
//

import Foundation

protocol EbookListPresenterProtocol: AnyObject {
    
}

class EbookListPresenter {
    
    private let interactor: EbookListInteractorProtocol
    private let router: EbookListRouterProtocol
    private let view: EbookListViewProtocol

    init(router: EbookListRouterProtocol,
         view: EbookListViewProtocol,
         interactor: EbookListInteractorProtocol) {
        self.router = router
        self.view = view
        self.interactor = interactor
    }
    
}

extension EbookListPresenter: EbookListPresenterProtocol {
    
}
