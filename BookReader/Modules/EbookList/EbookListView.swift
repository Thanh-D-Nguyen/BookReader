//
//  EbookListView.swift
//  BookReader
//
//  Created by Nguyen Van Thanh on 2022/04/09.
//

import UIKit

protocol EbookListViewProtocol: AnyObject {
    
}

class EbookListView: UIViewController {
    
    var presenter: EbookListPresenterProtocol!

    @IBOutlet
    private weak var ebooksTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        ebooksTableView.registerNib(cellClass: EbookListCell.self)
    }
}

extension EbookListView: EbookListViewProtocol {
    
}

extension EbookListView: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        100
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: EbookListCell = tableView.dequeueResuableCell(forIndexPath: indexPath)
        return cell
    }
}
