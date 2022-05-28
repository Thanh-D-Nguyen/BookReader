//
//  TextViewExtension.swift
//  BookReader
//
//  Created by Nguyen Van Thanh on 2022/05/04.
//

import UIKit

extension UITextView {
    var visibleRange: NSRange? {
        guard let start = closestPosition(to: contentOffset),
                  let end = characterRange(at: CGPoint(x: contentOffset.x + bounds.maxX,
                                                   y: contentOffset.y + bounds.maxY))?.end
        else { return nil }
        return NSMakeRange(offset(from: beginningOfDocument, to: start), offset(from: start, to: end))
    }
}
