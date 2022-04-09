//
//  AnimatedTextManager.swift
//  KinhLangNghiemMVP
//
//  Created by Nguyen Van Thanh on 2022/01/22.
//

import Foundation

class AnimatedTextManager {
    static let shared = AnimatedTextManager()
    
    private var textList: [String] = ["Vô thượng thậm thâm vi diệu pháp",
                                      "Bách thiên vạn kiếp nan tao ngộ",
                                      "Ngã kim kiến văn đắc thọ trì",
                                      "Nguyện giải Như-lai chân thiệt nghĩa.",
                                      
                                      "Pháp vi diệu thâm sâu vô lượng",
                                      "Trăm ngàn muôn kiếp khó tìm cầu",
                                      "Con nay thấy nghe được thọ trì",
                                      "Nguyện hiểu Như Lai nghĩa chân thật",
                                      "無上甚深微妙法",
                                      "百千萬劫難遭遇",
                                      "我今見聞得受持",
                                      "願解如來真實義"]
    private var timer: Timer?
    private var animatedLabel: DWAnimatedLabel!
    private var currentIndex = 0
    func startAnimated(onLabel label: DWAnimatedLabel) {
        animatedLabel = label
        if timer != nil {
            timer?.invalidate()
            timer = nil
        }
        timer = Timer(timeInterval: 3.0, target: self, selector: #selector(handleTimer), userInfo: nil, repeats: true)
        RunLoop.main.add(timer!, forMode: .common)
        timer?.fire()
    }
    
    @objc
    private func handleTimer() {
        if currentIndex == textList.count {
            currentIndex = 0
        }
        let nextText = textList[currentIndex]
        animatedLabel.startAnimation(duration: 2.0, nextText: nextText, nil)
        currentIndex += 1
    }
}
