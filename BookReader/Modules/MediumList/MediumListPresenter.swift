//
//  MediumListPresenter.swift
//  BookReader
//
//  Created by Nguyen Van Thanh on 2022/04/09.
//

import Foundation

protocol MediumListPresenterProtocol: AnyObject {
    var media: [Medium] { get }

    func viewDidLoad()
}

class MediumListPresenter {
    private let interactor: MediumListInteractorProtocol
    private let router: MediumListRouterProtocol
    private let view: MediumListViewProtocol

    var media: [Medium] = []
    
    init(router: MediumListRouterProtocol,
         view: MediumListViewProtocol,
         interactor: MediumListInteractorProtocol) {
        self.router = router
        self.view = view
        self.interactor = interactor
    }
}

extension MediumListPresenter: MediumListPresenterProtocol {
    func viewDidLoad() {
        media = MediumManangement.shared.getAll()
        view.didLoadMedia()
    }
}
