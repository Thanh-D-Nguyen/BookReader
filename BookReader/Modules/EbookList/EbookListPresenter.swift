//
//  EbookListPresenter.swift
//  BookReader
//
//  Created by Nguyen Van Thanh on 2022/04/09.
//

import Foundation

protocol EbookListPresenterProtocol: AnyObject {
    
    var books: [Book] { get }
    
    func viewDidLoad()
    
    func openBookAt(_ index: Int)
}

class EbookListPresenter {
    
    private let interactor: EbookListInteractorProtocol
    private let router: EbookListRouterProtocol
    private let view: EbookListViewProtocol
    
    var books: [Book] = []
    
    init(router: EbookListRouterProtocol,
         view: EbookListViewProtocol,
         interactor: EbookListInteractorProtocol) {
        self.router = router
        self.view = view
        self.interactor = interactor
    }
    
}

extension EbookListPresenter: EbookListPresenterProtocol {
    func viewDidLoad() {
        books = BookManagement.shared.getAll()
        print("----->>>", books[2])
        view.didLoadBooks()
    }
    
    func openBookAt(_ index: Int) {
        let book = books[index]
        router.openBookViewWith(book)
    }
}
