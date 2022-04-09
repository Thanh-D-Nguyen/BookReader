//
//  MediumListView.swift
//  BookReader
//
//  Created by Nguyen Van Thanh on 2022/04/09.
//

import UIKit

protocol MediumListViewProtocol: AnyObject {
    
}

class MediumListView: UIViewController {

    var presenter: MediumListPresenterProtocol!
    
    @IBOutlet
    private weak var mediumTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        mediumTableView.registerNib(cellClass: MediumCell.self)
    }
}

extension MediumListView: MediumListViewProtocol {
    
}

extension MediumListView: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 100
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: MediumCell = tableView.dequeueResuableCell(forIndexPath: indexPath)
        return cell
    }
}

extension MediumListView: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 55
    }
}
