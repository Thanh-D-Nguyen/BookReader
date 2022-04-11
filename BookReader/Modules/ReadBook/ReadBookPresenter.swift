//
//  ReadBookPresenter.swift
//  BookReader
//
//  Created by Nguyen Van Thanh on 2022/04/10.
//

import Foundation
import UIKit

protocol ReadBookPresenterProtocol: AnyObject {
    var statusBarHidden: Bool { get }
    
    func viewDidLoad()
}

class ReadBookPresenter: NSObject {
    private let interactor: ReadBookInteractorProtocol
    private let router: ReadBookRouterProtocol
    private let view: ReadBookViewProtocol

    private var pageView: UIPageViewController!
    
    var statusBarHidden: Bool = false
    
    init(router: ReadBookRouterProtocol,
         view: ReadBookViewProtocol,
         interactor: ReadBookInteractorProtocol) {
        self.router = router
        self.view = view
        self.interactor = interactor
    }

    @objc
    private func handlePageViewTap(_ gesture: UITapGestureRecognizer) {
        statusBarHidden = !statusBarHidden
        view.didChangeStatusBarHidden(statusBarHidden)
    }
}

extension ReadBookPresenter: ReadBookPresenterProtocol {
    func viewDidLoad() {
        pageView = UIPageViewController(transitionStyle: .pageCurl, navigationOrientation: .horizontal)
        pageView.dataSource = self
        pageView.delegate = self
        view.didLoadPageView(pageView)
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(handlePageViewTap))
        pageView.view.addGestureRecognizer(tapGesture)
        pageView.setViewControllers([UIViewController()], direction: .forward, animated: true)
    }
}

extension ReadBookPresenter: UIPageViewControllerDataSource {
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        let vc = UIViewController()
        vc.view.backgroundColor = .red
        return vc
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        let vc = UIViewController()
        vc.view.backgroundColor = .blue
        return vc
    }
}

extension ReadBookPresenter: UIPageViewControllerDelegate {
    
}
