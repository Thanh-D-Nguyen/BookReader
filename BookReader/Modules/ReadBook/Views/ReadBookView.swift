//
//  ReadBookView.swift
//  BookReader
//
//  Created by Nguyen Van Thanh on 2022/04/10.
//

import UIKit

protocol ReadBookViewProtocol: AnyObject {
    func didLoadPageView(_ pageView: UIPageViewController)
    
    func didChangeStatusBarHidden(_ isHidden: Bool)
}

class ReadBookView: UIViewController {
    
    @IBOutlet private weak var pageContainerView: UIView!
    
    @IBOutlet private weak var headerView: ReadBookHeadView!
    @IBOutlet private weak var footerView: ReadBookFootView!
    
    @IBOutlet private weak var headerContainerView: UIView!
    @IBOutlet private weak var topHeaderConstraint: NSLayoutConstraint!
    
    @IBOutlet private weak var footerContainerView: UIView!
    @IBOutlet private weak var bottomFotterConstraint: NSLayoutConstraint!
    
    var presenter: ReadBookPresenterProtocol!

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        presenter.viewDidLoad()
    }
    
    override var prefersStatusBarHidden: Bool {
        return presenter.statusBarHidden
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .default
    }
    
    override var preferredStatusBarUpdateAnimation: UIStatusBarAnimation {
        return .slide
    }
}

extension ReadBookView: ReadBookViewProtocol {
    func didLoadPageView(_ pageView: UIPageViewController) {
        addChild(pageView)
        pageContainerView.addAndFitSubview(pageView.view)
        pageView.didMove(toParent: self)
    }
    
    func didChangeStatusBarHidden(_ isHidden: Bool) {
        setNeedsStatusBarAppearanceUpdate()
        UIView.animate(withDuration: 0.25) {
            self.headerContainerView.alpha = isHidden ? 0.0 : 1.0
            self.footerContainerView.alpha = isHidden ? 0.0 : 1.0
        }
        
    }
}