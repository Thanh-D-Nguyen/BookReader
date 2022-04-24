//
//  ReadBookInteractor.swift
//  BookReader
//
//  Created by Nguyen Van Thanh on 2022/04/10.
//

import Foundation
import UIKit

protocol ReadBookInteractorProtocol: AnyObject {
    var parserProgress: ((Chapter, CGFloat) -> Void)? { get set }
    var finishParse: (([Chapter]) -> Void)? { get set }
    
    func unzipAndParse()
    func cancleAllParse()
    
    func getCurrentBook() -> RMBook
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

    private var currentParsedCount = 0
    private var isFinishParse = false
    private var totalLocations: UInt = 0
    private var chapterCount = 0
    
    var parserProgress: ((Chapter, CGFloat) -> Void)?
    var finishParse: (([Chapter]) -> Void)?
    
    init(book: Book) {
        self.book = book.asRealm()
        let bookPath = Bundle.main.path(forResource: book.fileName, ofType: nil)!
        self.bookPath = bookPath
    }
    
    func parseBookMeta() {
        parseQueue.cancelAllOperations()
        isFinishParse = false
        currentParsedCount = 0
        let resultList = NSMutableArray()
        
        for _ in 0 ..< chapterCount {
            resultList.add(NSNull())
        }
        
        for (index, spine) in bookMeta.spine.spineReferences.enumerated() {
            parseQueue.addOperation { [weak self] in
                guard let self = self else { return }
                self.parseSpine(spine, index: index, resultList: resultList)
            }
        }
    }
    
    private func parseSpine(_ spine: Spine, index: Int, resultList: NSMutableArray) {
        let tocRef = self.bookMeta.tableOfContentsMap[spine.resource.href] ?? FRTocReference.init(title: "", resource: spine.resource)
        guard let fullHref = tocRef.resource?.fullHref else {
            return
        }
        let title = tocRef.title ?? ""
        let baseUrl = URL(fileURLWithPath: fullHref)
        let htmlParser = HTMLParseInteractor(url: baseUrl)
        let chapter = Chapter()
        if htmlParser.parse() {
            chapter.title = title
            chapter.index = self.currentParsedCount
            chapter.locationOffset = totalLocations
            totalLocations += htmlParser.totalLocation
            chapter.baseUrl = fullHref
            chapter.text = htmlParser.currentString
            chapter.attributes = htmlParser.attributes
        }
        
        DispatchQueue.main.async {
            self.currentParsedCount += 1
            let progress = CGFloat(self.currentParsedCount + 1) / CGFloat(self.chapterCount)
            self.parserProgress?(chapter, progress)
            resultList.replaceObject(at: index, with: chapter)
            if self.currentParsedCount >= self.chapterCount {
                self.finishParse?(resultList as! [Chapter])
            }
        }
    }
}

extension ReadBookInteractor: ReadBookInteractorProtocol {
    func unzipAndParse() {
        DispatchQueue.global().async {
            if let bookMeta = try? FREpubParser().readEpub(epubPath: self.bookPath, unzipPath: Constants.bookUnzipPath) {
                self.bookMeta = bookMeta
                if let coverUrl = bookMeta.coverImage?.fullHref {
                    self.coverImage = UIImage(contentsOfFile: coverUrl)
                }
                self.chapterCount = bookMeta.spine.spineReferences.count
                DispatchQueue.main.async {
                    self.parseBookMeta()
                }
            }
        }
    }
    
    func cancleAllParse() {
        parseQueue.cancelAllOperations()
    }
    
    func getCurrentBook() -> RMBook {
        return self.book
    }
}
