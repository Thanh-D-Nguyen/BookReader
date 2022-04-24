//
//  ReadBookHeadView.swift
//  KinhLangNghiemMVP
//
//  Created by Nguyen Van Thanh on 2022/01/23.
//

import UIKit

enum HeaderViewAction {
    case chapter, styleChange, bookmark, close
}

protocol ReadingHeaderViewDelegate: AnyObject {
    func readingHeaderView(_ view: ReadBookHeadView, tapAction action: HeaderViewAction)
}

class ReadBookHeadView: UIView {
    
    weak var delegate: ReadingHeaderViewDelegate?
    
    private func setupView() {
        instantiate()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupView()
    }
    
    @IBAction
    private func close() {
        delegate?.readingHeaderView(self, tapAction: .close)
    }
    
    @IBAction
    private func actionShowChapters() {
        delegate?.readingHeaderView(self, tapAction: .chapter)
    }
    
    @IBAction
    private func actionStyleChange() {
        delegate?.readingHeaderView(self, tapAction: .styleChange)
    }
    
    @IBAction
    private func actionBookmark(sender: UIButton) {
        delegate?.readingHeaderView(self, tapAction: .bookmark)
    }
}

extension ReadBookHeadView: NibInstantiate {}
