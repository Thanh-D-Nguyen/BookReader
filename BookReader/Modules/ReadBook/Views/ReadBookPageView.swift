//
//  ReadBookPageView.swift
//  BookReader
//
//  Created by Nguyen Van Thanh on 2022/04/16.
//

import UIKit

class ReadBookPageView: UIViewController {
    
    @IBOutlet private weak var textView: DTRichTextEditorView!
    @IBOutlet private weak var locationLabel: UILabel!
    
    var page: Page?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        textView.isEditable = false
        textView.textSizeMultiplier = 1.2
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        print("TextView size", textView.bounds.size)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if page?.content != nil {
            textView.attributedText = page?.content
        }
    }
}

