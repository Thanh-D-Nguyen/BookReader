//
//  MainRouter.swift
//  BookReader
//
//  Created by Nguyen Van Thanh on 2022/04/09.
//

import UIKit

protocol MainRouterProtocol: AnyObject {
}

class MainRouter {
    
    private weak var mainView: MainView?
    
    init(view: MainView?) {
        self.mainView = view
    }
    
    class func loadModule() -> MainView {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        guard let view = storyboard.instantiateViewController(withIdentifier: "MainView") as? MainView else {
            assertionFailure("Can't load main view")
            return MainView()
        }
        let router = MainRouter(view: view)
        let interactor = MainInteractor()
        let presenter = MainPresenter(router: router, view: view, interactor: interactor)
        view.presenter = presenter
        return view
    }
}

extension MainRouter: MainRouterProtocol {
}
