//
//  LoadingPresenter.swift
//  eMarket
//
//  Created by Nguyen Van Thanh on 2021/11/26.
//

import Foundation

protocol LoadingPresenterProtocol: AnyObject {
    func viewDidLoad()
}
class LoadingPresenter {
    private let interactor: LoadingInteractorProtocol
    private let view: LoadingViewProtocol
    private let router: LoadingRouterProtocol
    
    init(interator: LoadingInteractorProtocol, view: LoadingViewProtocol, router: LoadingRouterProtocol) {
        self.interactor = interator
        self.router = router
        self.view = view
    }
    
    private func openMainView() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.2, execute: { [weak self] in
            guard let self = self else { return }
            self.router.navigateToMain()
        })
    }
}

extension LoadingPresenter: LoadingPresenterProtocol {
    func viewDidLoad() {
        interactor.didReadyToStart = { [weak self] in
            guard let self = self else { return }
            self.openMainView()
        }
        interactor.initialData()
    }
}
