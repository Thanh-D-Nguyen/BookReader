//
//  LoadingView.swift
//  eMarket
//
//  Created by Nguyen Van Thanh on 2021/11/26.
//

import UIKit

protocol LoadingViewProtocol: AnyObject { }

class LoadingView: UIViewController {
    var presenter: LoadingPresenterProtocol!

    override func viewDidLoad() {
        super.viewDidLoad()
        presenter.viewDidLoad()
    }
}

extension LoadingView: LoadingViewProtocol { }
