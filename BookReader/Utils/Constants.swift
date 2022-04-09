//
//  Constants.swift
//  KinhLangNghiemMVP
//
//  Created by Nguyen Van Thanh on 2022/02/11.
//

import UIKit

class Constants {
    static let defaultTextMargin: CGFloat = 26.0
    static let defaultLinkColor = 0x536FFA
    static let defaultFont = AvailableFont.TimesNewRoman
    static let defaultTextSize: CGFloat = 15.0
    static let defaultTextSizeMultipler = 12
    static let defaultPageSize: CGSize = CGSize(width: 320, height: 480)
    static let defaultLineHeightMultiplier: CGFloat = 1.1
    
    static let defaultParagraphSpacing: CGFloat = 10
    static let defaultLineSpacing: CGFloat = 2
    
    /// epub books path
    static let bookUnzipPath: String = {
        let docPath = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).first!
        let path = docPath + "/books"
        if !FileManager.default.fileExists(atPath: path) {
            try? FileManager.default.createDirectory(at: URL(fileURLWithPath: path), withIntermediateDirectories: true, attributes: nil)
        }
        return path
    }()
    
    static func inLibrarayFolder(fileName: String) -> URL {
        return URL(fileURLWithPath: NSSearchPathForDirectoriesInDomains(.libraryDirectory, .userDomainMask, true)[0], isDirectory: true)
            .appendingPathComponent(fileName)
    }
    
    static func inDocumentFolder(fileName: String) -> URL {
        return FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0].appendingPathComponent(fileName)
    }
}
