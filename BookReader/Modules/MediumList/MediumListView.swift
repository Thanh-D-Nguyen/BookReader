//
//  MediumListView.swift
//  BookReader
//
//  Created by Nguyen Van Thanh on 2022/04/09.
//

import UIKit

protocol MediumListViewProtocol: AnyObject {
    
    var mainNav: UINavigationController? { get set }
    
    func didLoadMedia()
}

class MediumListView: UIViewController {

    var presenter: MediumListPresenterProtocol!
    
    weak var mainNav: UINavigationController?
    
    @IBOutlet
    private weak var mediumTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        mediumTableView.registerNib(cellClass: MediumCell.self)
        presenter.viewDidLoad()
    }
}

extension MediumListView: MediumListViewProtocol {
    func didLoadMedia() {
        mediumTableView.reloadData()
    }
}

extension MediumListView: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        presenter.media.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: MediumCell = tableView.dequeueResuableCell(forIndexPath: indexPath)
        cell.updateMedium(presenter.media[indexPath.row])
        return cell
    }
}

extension MediumListView: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 55
    }
}
