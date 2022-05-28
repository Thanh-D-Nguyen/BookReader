//
//  ScrollView.swift
//  BookReader
//
//  Created by Nguyen Van Thanh on 2022/05/28.
//

import UIKit

extension UIScrollView {
    func getCurrentScrollIndex(pageCount: Int) -> Int {
        let width = self.frame.width
        var currentPageIndex = Int((self.contentOffset.x + (0.5 * width)) / width)
        if (currentPageIndex < 0) {
            currentPageIndex = 0
        } else if (currentPageIndex >= pageCount) {
            currentPageIndex = pageCount - 1
        }
        return currentPageIndex
    }
}
