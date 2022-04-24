//
//  ReadBookRouter.swift
//  BookReader
//
//  Created by Nguyen Van Thanh on 2022/04/10.
//

import UIKit

protocol ReadBookRouterProtocol: AnyObject {
    func back()
}

class ReadBookRouter {
    private weak var view: ReadBookView?
    
    init(view: ReadBookView?) {
        self.view = view
    }
    
    class func loadModule(_ book: Book) -> ReadBookView {
        let storyboard = UIStoryboard(name: "ReadBook", bundle: nil)
        guard let view = storyboard.instantiateViewController(withIdentifier: "ReadBookView") as? ReadBookView else {
            assertionFailure("Can't load view")
            return ReadBookView()
        }
        view.title = "Medium"
        let router = ReadBookRouter(view: view)
        let interactor = ReadBookInteractor(book: book)
        let presenter = ReadBookPresenter(router: router, view: view, interactor: interactor)
        view.presenter = presenter
        return view
    }
    
    class func createBookPageView() -> ReadBookPageView {
        let storyboard = UIStoryboard(name: "ReadBook", bundle: nil)
        guard let view = storyboard.instantiateViewController(withIdentifier: "ReadBookPageView") as? ReadBookPageView else {
            assertionFailure("Can't load view")
            return ReadBookPageView()
        }
        return view
    }
}

extension ReadBookRouter: ReadBookRouterProtocol {
    func back() {
        view?.navigationController?.popViewController(animated: true)
    }
}
