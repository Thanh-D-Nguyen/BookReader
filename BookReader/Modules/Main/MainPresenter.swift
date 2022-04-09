//
//  MainPresenter.swift
//  BookReader
//
//  Created by Nguyen Van Thanh on 2022/04/09.
//

import UIKit

protocol MainPresenterProtocol: AnyObject {
    func viewDidLoad()
    func viewWillAppear()
}

class MainPresenter {
    private let interactor: MainInteractorProtocol
    private let router: MainRouterProtocol
    private let view: MainViewProtocol

    init(router: MainRouterProtocol,
         view: MainViewProtocol,
         interactor: MainInteractorProtocol) {
        self.router = router
        self.view = view
        self.interactor = interactor
    }
}

extension MainPresenter: MainPresenterProtocol {
    func viewDidLoad() {
        let bookView = EbookListRouter.loadModule()
        view.didLoadBookView(bookView.view)
        let mediumView = MediumListRouter.loadModule()
        view.didLoadMediumView(mediumView.view)
    }
    func viewWillAppear() {
    }
}
