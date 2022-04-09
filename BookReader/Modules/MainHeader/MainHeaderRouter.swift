//
//  MainHeaderRouter.swift
//  BookReader
//
//  Created by Nguyen Van Thanh on 2022/04/09.
//

import UIKit

protocol MainHeaderRouterProtocol: AnyObject {
    
}

class MainHeaderRouter {

    private weak var view: MainHeaderView?
    
    init(view: MainHeaderView?) {
        self.view = view
    }
    
    class func loadModule() -> MainHeaderView {
        let storyboard = UIStoryboard(name: "MainHeader", bundle: nil)
        guard let view = storyboard.instantiateViewController(withIdentifier: "MainHeaderView") as? MainHeaderView else {
            assertionFailure("Can't load main view")
            return MainHeaderView()
        }
        let router = MainHeaderRouter(view: view)
        let interactor = MainHeaderInteractor()
        let presenter = MainHeaderPrensenter(router: router, view: view, interactor: interactor)
        view.presenter = presenter
        return view
    }
}

extension MainHeaderRouter: MainHeaderRouterProtocol {
    
}
