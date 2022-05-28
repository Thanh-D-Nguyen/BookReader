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
        textView.layoutManager.allowsNonContiguousLayout = false
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        guard let page = page else {
            return
        }
        textView.attributedText = page.content
        locationLabel.text = page.locationInfoText
    }
}

extension ReadBookPageView: UITextViewDelegate {
}
