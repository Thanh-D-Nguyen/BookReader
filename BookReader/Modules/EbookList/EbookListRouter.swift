//
//  EbookListRouter.swift
//  BookReader
//
//  Created by Nguyen Van Thanh on 2022/04/09.
//

import UIKit

protocol EbookListRouterProtocol: AnyObject {
    func openBookViewWith(_ book: Book)
}

class EbookListRouter {
    private weak var view: EbookListView?
    
    init(view: EbookListView?) {
        self.view = view
    }
    
    class func loadModule() -> EbookListView {
        let storyboard = UIStoryboard(name: "EbookList", bundle: nil)
        guard let view = storyboard.instantiateViewController(withIdentifier: "EbookListView") as? EbookListView else {
            assertionFailure("Can't load view")
            return EbookListView()
        }
        view.title = "Ebooks"
        let router = EbookListRouter(view: view)
        let interactor = EbookListInteractor()
        let presenter = EbookListPresenter(router: router, view: view, interactor: interactor)
        view.presenter = presenter
        return view
    }
}

extension EbookListRouter: EbookListRouterProtocol {
    func openBookViewWith(_ book: Book) {
        let readBookView = ReadBookRouter.loadModule(book)
        view?.mainNav?.pushViewController(readBookView, animated: true)
    }
}
