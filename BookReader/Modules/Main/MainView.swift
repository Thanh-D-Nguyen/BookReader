//
//  MainView.swift
//  BookReader
//
//  Created by Nguyen Van Thanh on 2022/04/09.
//

import UIKit
import BetterSegmentedControl

protocol MainViewProtocol: AnyObject {
    func didLoadBookView(_ view: UIView)
    func didLoadMediumView(_ view: UIView)
}

class MainView: UIViewController {
    var presenter: MainPresenterProtocol!
    
    @IBOutlet private weak var segmentedView: BetterSegmentedControl!
    @IBOutlet private weak var mainScrollView: UIScrollView!
    
    @IBOutlet private weak var bookContainerView: UIView!
    @IBOutlet private weak var mediumContainerView: UIView!

    private func prepareView() {
        let segments = LabelSegment.segments(withTitles: ["Ebook", "Medium"],
                                             normalTextColor: .white,
                                             selectedTextColor: UIColor(red: 0.92, green: 0.29, blue: 0.15, alpha: 1.00))
        segmentedView.segments = segments
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter.viewDidLoad()
        prepareView()
    }

    @IBAction
    private func segmentIndexChanged(_ sender: BetterSegmentedControl) {
        let contentOffset = CGPoint(x: mainScrollView.bounds.width * CGFloat(sender.index), y: 0)
        mainScrollView.setContentOffset(contentOffset, animated: true)
    }
}

extension MainView: MainViewProtocol {
    func didLoadBookView(_ view: UIView) {
        bookContainerView.addAndFitSubview(view)
    }
    func didLoadMediumView(_ view: UIView) {
        mediumContainerView.addAndFitSubview(view)
    }
}

extension MainView: UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let width = scrollView.bounds.width
        let index = Int((scrollView.contentOffset.x + (0.5 * width)) / width)
        if index != segmentedView.index {
            segmentedView.setIndex(index)
        }
    }
}
