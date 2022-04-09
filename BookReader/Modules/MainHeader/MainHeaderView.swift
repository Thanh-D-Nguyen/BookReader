//
//  MainHeaderView.swift
//  BookReader
//
//  Created by Nguyen Van Thanh on 2022/04/09.
//

import UIKit

protocol MainHeaderViewProtocol: AnyObject {
    
}

class MainHeaderView: UIViewController {
    
    var presenter: MainHeaderPrensenterProtocol!

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
}

extension MainHeaderView: MainHeaderViewProtocol {
    
}
