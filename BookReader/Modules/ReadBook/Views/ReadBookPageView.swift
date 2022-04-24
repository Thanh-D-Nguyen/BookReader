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
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        textView.attributedText = page?.content
    }
}

