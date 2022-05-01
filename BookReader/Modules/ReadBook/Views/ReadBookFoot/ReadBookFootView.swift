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
    @IBOutlet private weak var progressView: UIProgressView!
    
    private func setupView() {
        instantiate()
        progressSlider.isHidden = true
        progressSlider.value = 0.0
        progressSlider.minimumValue = 0.0
        progressView.progress = 0.0
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupView()
    }
    
    func updateCurrentLoc(_ currentLoc: Int, totalLoc: Int) {
        self.infoLabel.text = Utils.formatLocation(currentLoc, total: totalLoc)
        self.progressSlider.value = Float(currentLoc)
        progressSlider.maximumValue = Float(totalLoc)
    }
    
    func updateParseProgress(_ progress: CGFloat) {
        progressView.setProgress(Float(progress), animated: true)
        let isDone = progress >= 1.0
        progressView.isHidden = isDone
        progressSlider.isHidden = !isDone
    }

}

extension ReadBookFootView: NibInstantiate {}
