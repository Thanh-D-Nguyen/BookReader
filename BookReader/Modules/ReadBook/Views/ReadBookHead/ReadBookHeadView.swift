//
//  ReadBookHeadView.swift
//  KinhLangNghiemMVP
//
//  Created by Nguyen Van Thanh on 2022/01/23.
//

import UIKit

protocol ReadingHeaderViewDelegate: AnyObject {
    func readingHeaderViewDidTapChapters(_ view: ReadBookHeadView)
    func readingHeaderViewDidTapStyleChange(_ view: ReadBookHeadView)
    func readingHeaderViewDidTapBookmark(_ view: ReadBookHeadView)
    func readingHeaderViewDidTapClose(_ view: ReadBookHeadView)
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
        delegate?.readingHeaderViewDidTapClose(self)
    }
    
    @IBAction
    private func actionShowChapters() {
        delegate?.readingHeaderViewDidTapChapters(self)
    }
    
    @IBAction
    private func actionStyleChange() {
        delegate?.readingHeaderViewDidTapStyleChange(self)
    }
    
    @IBAction
    private func actionBookmark(sender: UIButton) {
        delegate?.readingHeaderViewDidTapBookmark(self)
    }
}

extension ReadBookHeadView: NibInstantiate {}
