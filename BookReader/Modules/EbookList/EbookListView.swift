//
//  EbookListView.swift
//  BookReader
//
//  Created by Nguyen Van Thanh on 2022/04/09.
//

import UIKit

protocol EbookListViewProtocol: AnyObject {
    var mainNav: UINavigationController? { get set }

    func didLoadBooks()
}

class EbookListView: UIViewController {
    
    var presenter: EbookListPresenterProtocol!
    weak var mainNav: UINavigationController?
    
    @IBOutlet
    private weak var ebooksTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        ebooksTableView.registerNib(cellClass: EbookListCell.self)
        presenter.viewDidLoad()
    }
}

extension EbookListView: EbookListViewProtocol {
    func didLoadBooks() {
        ebooksTableView.reloadData()
    }
}

extension EbookListView: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        presenter.books.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: EbookListCell = tableView.dequeueResuableCell(forIndexPath: indexPath)
        cell.updateBook(presenter.books[indexPath.row])
        return cell
    }
}

extension EbookListView: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        presenter.openBookAt(indexPath.row)
    }
}
