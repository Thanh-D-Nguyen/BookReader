//
//  MediumListRouter.swift
//  BookReader
//
//  Created by Nguyen Van Thanh on 2022/04/09.
//

import UIKit

protocol MediumListRouterProtocol: AnyObject {
    
}

class MediumListRouter {
    private weak var view: MediumListView?
    
    init(view: MediumListView?) {
        self.view = view
    }
    
    class func loadModule() -> MediumListView {
        let storyboard = UIStoryboard(name: "MediumList", bundle: nil)
        guard let view = storyboard.instantiateViewController(withIdentifier: "MediumListView") as? MediumListView else {
            assertionFailure("Can't load view")
            return MediumListView()
        }
        view.title = "Medium"
        let router = MediumListRouter(view: view)
        let interactor = MediumListInteractor()
        let presenter = MediumListPresenter(router: router, view: view, interactor: interactor)
        view.presenter = presenter
        return view
    }
}

extension MediumListRouter: MediumListRouterProtocol {
    
}
