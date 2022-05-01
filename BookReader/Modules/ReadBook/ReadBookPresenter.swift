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
    var didUpdateParseProgress: ((CGFloat) -> Void)? { get set }
    var didUpdateSliderLocation: ((Int, Int) -> Void)? { get set }
    
    func viewDidLoad()
    
    func viewWillDisapear()
    
    func headerTapAction(_ action: HeaderViewAction)
    
    func scrollTextToTop()
}

class ReadBookPresenter: NSObject {
    private let interactor: ReadBookInteractorProtocol
    private let router: ReadBookRouterProtocol
    private let view: ReadBookViewProtocol
    
    private let bookConfig: Book
    private var chapters: [Chapter] = []
    private var readingAttributedString = NSAttributedString(string: "")
    
    private var pageView: UIPageViewController!
    private var currentPageItemView: ReadBookPageView!
    
    private var readingChapter = 0
    var statusBarHidden: Bool = false
    
    var didUpdateParseProgress: ((CGFloat) -> Void)?
    var didUpdateSliderLocation: ((Int, Int) -> Void)?
    
    init(router: ReadBookRouterProtocol,
         view: ReadBookViewProtocol,
         interactor: ReadBookInteractorProtocol) {
        self.router = router
        self.view = view
        self.interactor = interactor
        self.bookConfig = interactor.getCurrentBook()
        readingChapter = 1
    }

    @objc
    private func handlePageViewTap(_ gesture: UITapGestureRecognizer) {
        statusBarHidden = !statusBarHidden
        view.didChangeStatusBarHidden(statusBarHidden)
    }
    
    private func preparePageView() {
        pageView = UIPageViewController(transitionStyle: .pageCurl, navigationOrientation: .horizontal)
        pageView.dataSource = self
        pageView.delegate = self
        view.didLoadPageView(pageView)
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(handlePageViewTap))
        pageView.view.addGestureRecognizer(tapGesture)
    }
    
    private func didParseChapter(_ chapter: Chapter, progress: CGFloat) {
        self.didUpdateParseProgress?(progress - 0.2)
    }
    
    private func prepareReadingChapter() {
        let url = URL(fileURLWithPath: chapters[readingChapter].baseUrl)
        guard let attributedString = try? NSMutableAttributedString.init(url: url, options: [.documentType: NSAttributedString.DocumentType.html], documentAttributes: nil) else {
            return
        }
        attributedString.enumerateAttributes(in: NSRange(location: 0, length: attributedString.length), options: .longestEffectiveRangeNotRequired) { atts, range, _ in
            if let font = atts[.font] as? UIFont {
                let replaceFont = bookConfig.font.withSize(font.pointSize * 2.5)
                attributedString.addAttribute(.font, value: replaceFont, range: range)
            }
        }
        readingAttributedString = attributedString
    }
    
    private func didFinishParseChapters(_ chapters: [Chapter], totalLocation: Int) {
        self.chapters = chapters
        prepareReadingChapter()
        self.didUpdateParseProgress?(1.0)
        self.updateCurrentReading()
        didUpdateSliderLocation?(0, totalLocation)
    }
    
    private func updateCurrentReading() {
        let page = getCurrentReadingPage()
        currentPageItemView = ReadBookRouter.createBookPageView()
        currentPageItemView.page = page
        self.pageView.setViewControllers([currentPageItemView], direction: .forward, animated: true)
    }
    
    private func getCurrentReadingPage() -> Page? {
        let page = Page(range: NSRange(location: 0, length: 0), index: 1, startLocation: 0, endLocation: 400, content: readingAttributedString)
        return page
    }
}

extension ReadBookPresenter: ReadBookPresenterProtocol {
    func viewDidLoad() {
        preparePageView()
        interactor.unzipAndParse()
        
        interactor.parserProgress = { [weak self] chapter, progress in
            guard let self = self else { return }
            self.didParseChapter(chapter, progress: progress)
        }
        
        interactor.finishParse = { [weak self] chapters, totalLocation in
            guard let self = self else { return }
            DispatchQueue.main.async {
                self.didFinishParseChapters(chapters, totalLocation: totalLocation)
            }
        }
    }
    
    func viewWillDisapear() {
        interactor.cancleAllParse()
    }
    
    func headerTapAction(_ action: HeaderViewAction) {
        switch action {
        case .chapter:
            break
        case .styleChange:
            break
        case .bookmark:
            break
        case .close:
            router.back()
        }
    }
    
    func scrollTextToTop() {
        if let currentVC = currentPageItemView {
            currentVC.scrollTextToTop()
        }
    }
}

extension ReadBookPresenter: UIPageViewControllerDataSource {
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        let vc = UIViewController()
        vc.view.backgroundColor = .red
        return vc
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        if let page = currentPageItemView.page {
            let pageView = ReadBookRouter.createBookPageView()
            let newPage = getCurrentReadingPage()
            pageView.page = newPage
            readingChapter += 1
            return pageView
            
        }
        return nil
    }
}

extension ReadBookPresenter: UIPageViewControllerDelegate {
    func pageViewController(_ pageViewController: UIPageViewController, willTransitionTo pendingViewControllers: [UIViewController]) {
        guard let nextView = pendingViewControllers.first as? ReadBookPageView else { return }
        currentPageItemView = nextView
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, didFinishAnimating finished: Bool, previousViewControllers: [UIViewController], transitionCompleted completed: Bool) {
        if completed { return }
        guard let prevView = previousViewControllers.first as? ReadBookPageView else { return }
        currentPageItemView = prevView
    }
}
