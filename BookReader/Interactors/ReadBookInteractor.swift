//
//  ReadBookInteractor.swift
//  BookReader
//
//  Created by Nguyen Van Thanh on 2022/04/10.
//

import Foundation
import UIKit

protocol ReadBookInteractorProtocol: AnyObject {
}

class ReadBookInteractor {
    private let book: RMBook
    private let bookPath: String
    private var bookMeta: FRBook!
    private var coverImage: UIImage?
    
    private var parseQueue: OperationQueue = {
        let queue = OperationQueue()
        queue.name = "book_parse_queue"
        let cores = ProcessInfo.processInfo.activeProcessorCount
        queue.maxConcurrentOperationCount = cores
        queue.qualityOfService = .default
        return queue
    }()
    
    private var chapters: [Chapter] = []

    private var parseQueueId = 0
    private var currentParsedCount = 0
    private var isFinishParse = false
    private var totalPageCount = 0
    private var chapterCount = 0
    private var chapterOffset = 0
    
    init(book: Book) {
        self.book = book.asRealm()
        let bookPath = Bundle.main.path(forResource: book.fileName, ofType: nil)!
        self.bookPath = bookPath
    }
    
    func unzipAndParse() {
        DispatchQueue.global().async {
            if let bookMeta = try? FREpubParser().readEpub(epubPath: self.bookPath, unzipPath: Constants.bookUnzipPath) {
                self.bookMeta = bookMeta
                if let coverUrl = bookMeta.coverImage?.fullHref {
                    self.coverImage = UIImage(contentsOfFile: coverUrl)
                }
                self.chapterCount = bookMeta.spine.spineReferences.count
                self.chapterOffset = self.chapterCount - bookMeta.flatTableOfContents.count
                DispatchQueue.main.async {
                    self.parseBookMeta()
                }
            }
        }
    }
}

extension ReadBookInteractor: ReadBookInteractorProtocol {
    
}

extension ReadBookInteractor {
    func finishParse(chapterList: [AnyObject]) {
        self.chapters.removeAll()
        var pageOffset = 0
        var pageCount = 0
        for item in chapterList {
            if !(item is Chapter) {
                continue
            }
            var chapter = item as! Chapter
            chapter.pageOffset = pageOffset
            pageOffset += chapter.pages.count
            pageCount += chapter.pages.count
            self.chapters.append(chapter)
        }
        self.totalPageCount = pageCount
        isFinishParse = true
    }
    
    func parseChapter(_ chapter: Chapter, resultList: NSMutableArray, queueId: Int) {
        DispatchQueue.main.async {
            if queueId != self.parseQueueId { return }
            self.currentParsedCount += 1
            resultList.replaceObject(at: chapter.index, with: chapter)
            // progress: Float(self.currentParsedCount) / Float(self.chapterCount)
            if self.currentParsedCount >= self.chapterCount {
                self.finishParse(chapterList: resultList as Array)
            }
        }
    }
    
    func parseSpine(_ spine: Spine, index: Int, resultList: NSMutableArray, queueId: Int) {
        let tocReference: FRTocReference = self.bookMeta.tableOfContentsMap[spine.resource.href] ?? FRTocReference.init(title: "", resource: spine.resource)
        let title = tocReference.title ?? ""
        let urlString = tocReference.resource?.fullHref ?? ""
        let url = URL(string: urlString)!
        let chapter = Chapter(title: title, index: index, pageOffset: 0, baseUrl: url, pages: [])

        DispatchQueue.main.async {
            if queueId != self.parseQueueId { return }
            self.currentParsedCount += 1
            resultList.replaceObject(at: chapter.index, with: chapter)
//            self.parseDelegate?.book(self, currentParseProgress: Float(self.currentParsedCount) / Float(self.chapterCount))
            if self.currentParsedCount >= self.chapterCount {
                self.finishParse(chapterList: resultList as Array)
            }
        }
    }
    
    func cancleAllParse() {
        parseQueue.cancelAllOperations()
    }
    
    func parseBookMeta() {
        parseQueueId += 1
        parseQueue.cancelAllOperations()
        isFinishParse = false
        currentParsedCount = 0
        // self.parseDelegate?.bookBeginParse(self)
        let currentQueueId = parseQueueId
        
        let resultList = NSMutableArray()
        
        for _ in 0 ..< chapterCount {
            resultList.add(NSNull())
        }
        if chapters.count > 0 && chapters.count == self.chapterCount {
            for chapter in chapters {
                parseQueue.addOperation { [weak self] in
                    self?.parseChapter(chapter, resultList: resultList, queueId: currentQueueId)
                }
            }
        } else {
            for (index, spine) in bookMeta.spine.spineReferences.enumerated() {
                parseQueue.addOperation { [weak self] in
                    self?.parseSpine(spine, index: index, resultList: resultList, queueId: currentQueueId)
                }
            }
        }
    }
}
