//
//  LoadingRouter.swift
//  eMarket
//
//  Created by Nguyen Van Thanh on 2021/11/26.
//

import UIKit

protocol LoadingRouterProtocol: AnyObject {
    func navigateToMain()
}

class LoadingRouter {
    private weak var loadingView: LoadingView?
    
    init(view: LoadingView) {
        loadingView = view
    }
    
    class func loadModule() -> LoadingView {
        let storyboard = UIStoryboard(name: "Loading", bundle: nil)
        guard let view = storyboard.instantiateViewController(withIdentifier: "LoadingView") as? LoadingView else {
            assertionFailure("Can't load main view")
            return LoadingView()
        }
        let router = LoadingRouter(view: view)
        let interactor = LoadingInteractor()
        let presenter = LoadingPresenter(interator: interactor, view: view, router: router)
        view.presenter = presenter
        return view
    }
}

extension LoadingRouter: LoadingRouterProtocol {
    func navigateToMain() {
        let mainView = MainRouter.loadModule()
        let sceneDelegate = UIApplication.shared.connectedScenes.first?.delegate as? SceneDelegate
        sceneDelegate?.window?.rootViewController = mainView
    }
}

