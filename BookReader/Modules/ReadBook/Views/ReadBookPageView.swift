//
//  ReadBookPageView.swift
//  BookReader
//
//  Created by Nguyen Van Thanh on 2022/04/16.
//

import UIKit

class ReadBookPageView: UIViewController {
    
    @IBOutlet private weak var textView: UITextView!
    @IBOutlet private weak var locationLabel: UILabel!
    
    var page: Page?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        textView.contentInset = .zero
        textView.textContainerInset = .zero
        textView.delegate = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        textView.attributedText = page?.content
    }
    
    func scrollTextToTop() {
        textView.scrollsToTop = true
    }
}

extension ReadBookPageView: UITextViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let rect = CGRect(x: 0, y: scrollView.contentOffset.y, width: scrollView.bounds.width, height: 30)
        let range = textView.layoutManager.glyphRange(forBoundingRect: rect, in: textView.textContainer)
        let total = page?.content.length ?? 1
        locationLabel.text = Utils.formatLocation(range.location, total: total)
    }
}
