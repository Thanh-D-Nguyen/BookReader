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
    func navigateToLocation(_ location: Int)
}

class ReadBookPresenter: NSObject {
    private let interactor: ReadBookInteractorProtocol
    private let router: ReadBookRouterProtocol
    private let view: ReadBookViewProtocol
    
    private let bookConfig: Book
    private var chapters: [Chapter] = []
    private var readingPages: [Page] = []
    
    private var totalLocation: Int = 0
    
    private var pageView: UIPageViewController!
    private var currentPageItemView: ReadBookPageView!
    
    private var readingChapter = 0
    private var readingPageInChapter = 0
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
    
    private func pagingAttributedString(_ attString: NSAttributedString) -> [Page] {
        if attString.length == 0 { return [] }
        let chapterLocationOffset = chapters[readingChapter].locationOffset
        
        let pageModel = Page(range: .init(location: 0, length: 0), content: attString, chapterOffset: chapterLocationOffset, totalLocation: totalLocation)
        self.readingPages = [pageModel]
        
        let textStorage = NSTextStorage(attributedString: attString)
        let layoutManager = NSLayoutManager()
        textStorage.addLayoutManager(layoutManager)
        let textContainer = NSTextContainer(size: Book.windowSize)
        layoutManager.addTextContainer(textContainer)
        var visibleRange = layoutManager.glyphRange(for: textContainer)
        
        if visibleRange == NSRange(location: 0, length: 0) {
            let pageModel = Page(range: .init(location: 0, length: 0), content: attString, chapterOffset: chapterLocationOffset, totalLocation: totalLocation)
            return [pageModel]
        }
        var pageOffset = visibleRange.location + visibleRange.length
        var pageList: [Page] = []
        while pageOffset <= attString.length, pageOffset != 0 {
            let splitContent = attString.attributedSubstring(from: visibleRange)
            let pageModel = Page(range: visibleRange, content: splitContent, chapterOffset: chapterLocationOffset, totalLocation: totalLocation)
            pageList.append(pageModel)
            
            let moreTextContainer = NSTextContainer(size: Book.windowSize)
            layoutManager.addTextContainer(moreTextContainer)
            let textRect = CGRect(origin: .zero, size: Book.windowSize)
            visibleRange = layoutManager.glyphRange(forBoundingRect: textRect, in: moreTextContainer)
            
            if visibleRange.location == NSNotFound {
                pageOffset = 0
            } else {
                pageOffset = visibleRange.location + visibleRange.length
            }
        }
        return pageList
    }
    
    private func prepareReadingChapter() {
        let url = URL(fileURLWithPath: chapters[readingChapter].baseUrl)
        guard let attributedString = try? NSMutableAttributedString(url: url, options: [.documentType: NSAttributedString.DocumentType.html], documentAttributes: nil) else {
            return
        }
        attributedString.enumerateAttributes(in: NSRange(location: 0, length: attributedString.length), options: .longestEffectiveRangeNotRequired) { atts, range, _ in
            if let font = atts[.font] as? UIFont {
                let replaceFont = bookConfig.font.withSize(font.pointSize * 2.5)
                attributedString.addAttribute(.font, value: replaceFont, range: range)
            }
        }
        self.readingPages = pagingAttributedString(attributedString)
    }
    
    private func didFinishParseChapters(_ chapters: [Chapter]) {
        self.chapters = chapters
        prepareReadingChapter()
        self.didUpdateParseProgress?(1.0)
        self.updateCurrentReading()
        didUpdateSliderLocation?(0, totalLocation)
    }
    
    private func updateCurrentReading() {
        let page = readingPages[readingPageInChapter]
        currentPageItemView = ReadBookRouter.createBookPageView()
        currentPageItemView.page = page
        self.pageView.setViewControllers([currentPageItemView], direction: .forward, animated: true)
    }
    
    private func pageIndexInLoction(_ loc: Int) -> Int {
        for (index, item) in readingPages.enumerated() {
            if loc >= item.range.location && loc < item.range.location + item.range.length {
                return index
            }
        }
        return 0
    }
    
    private func preparePagesAndNavigateToLocation(_ location: Int) {
        for chapter in chapters where chapter.locationOffset >= location {
            readingChapter = chapter.index
            break
        }
        prepareReadingChapter()
        let locationInChapter = location - chapters[readingChapter].locationOffset
        readingPageInChapter = pageIndexInLoction(locationInChapter)
        self.updateCurrentReading()
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
            self.totalLocation = totalLocation
            DispatchQueue.main.async {
                self.didFinishParseChapters(chapters)
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
    
    func navigateToLocation(_ location: Int) {
        preparePagesAndNavigateToLocation(location)
    }
}

extension ReadBookPresenter: UIPageViewControllerDataSource {
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        let pageView = ReadBookRouter.createBookPageView()
        readingPageInChapter -= 1
        if readingPageInChapter < 0 {
            readingPageInChapter += 1
            return nil
        }
        pageView.page = readingPages[readingPageInChapter]
        return pageView
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        let pageView = ReadBookRouter.createBookPageView()
        readingPageInChapter += 1
        if readingPageInChapter > readingPages.count - 1 {
            readingPageInChapter -= 1
            return nil
        }
        pageView.page = readingPages[readingPageInChapter]
        return pageView
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
