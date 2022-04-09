//
//  LoadingIndicatorVIew.swift
//  eMarket
//
//  Created by Nguyen Van Thanh on 2021/11/27.
//

import UIKit

class LoadingIndicatorView: UIView {

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

}
extension LoadingIndicatorView: NibInstantiate {}
