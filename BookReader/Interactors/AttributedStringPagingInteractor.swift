//
//  AttributedStringPagingInteractor.swift
//  BookReader
//
//  Created by Nguyen Van Thanh on 2022/05/01.
//

import UIKit

class AttributedStringPagingInteractor {
    
    private var attributedString: NSAttributedString
    private var pageSize: CGSize

    init(attString: NSAttributedString, pageSize: CGSize) {
        self.attributedString = attString
        self.pageSize = pageSize
    }
    
    func getNextPageFromRange(_ range: NSRange) -> Page? {
        let fullLength = attributedString.length
        let loc = range.location + range.length
        let splitRage = NSRange(location: loc, length: fullLength - loc)
        let htmlString = attributedString.attributedSubstring(from: splitRage)
        let textLayout = DTCoreTextLayouter(attributedString: htmlString)
        let textRect = CGRect(origin: .zero, size: pageSize)
        let layoutFrame = textLayout?.layoutFrame(with: textRect, range: NSMakeRange(0, htmlString.length))
        print("layoutFrame", layoutFrame!.frame)
        if let visibleRange = layoutFrame?.visibleStringRange(), visibleRange != NSRange(location: 0, length: 0) {
            let content = htmlString.attributedSubstring(from: visibleRange)
            let pageRage = NSRange(location: loc, length: visibleRange.length)
            let page = Page(range: pageRage, content: content)
            return page
        }
        return nil
    }
    
    func getPrevPageToRange(_ range: NSRange) -> Page? {
        let fullLength = attributedString.length
        let loc = range.location + range.length
        let splitRage = NSRange(location: loc, length: fullLength - loc)
        let htmlString = attributedString.attributedSubstring(from: splitRage)
        let textLayout = DTCoreTextLayouter(attributedString: htmlString)
        let textRect = CGRect(origin: .zero, size: pageSize)
        let layoutFrame = textLayout?.layoutFrame(with: textRect, range: NSMakeRange(0, htmlString.length))
        
        if let visibleRange = layoutFrame?.visibleStringRange(), visibleRange != NSRange(location: 0, length: 0) {
            let content = htmlString.attributedSubstring(from: visibleRange)
            let pageRage = NSRange(location: loc, length: visibleRange.length)
            let page = Page(range: pageRage, content: content)
            return page
        }
        return nil
    }
}
