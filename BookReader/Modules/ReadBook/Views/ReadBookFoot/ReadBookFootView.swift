//
//  ReadBookFootView.swift
//  KinhLangNghiemMVP
//
//  Created by Nguyen Van Thanh on 2022/01/23.
//

import UIKit

class ReadBookFootView: UIView {

    @IBOutlet private weak var infoLabel: UILabel!
    @IBOutlet private weak var progressSlider: UISlider!
    
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
    
    func updateInforText(_ text: String) {
        self.infoLabel.text = text
    }

}

extension ReadBookFootView: NibInstantiate {}
