//
//  Book.swift
//  KinhLangNghiemVIP
//
//  Created by Nguyen Van Thanh on 2022/01/15.
//

import Foundation
import UIKit

struct Book: Codable {
    let uid: String
    let title: String
    let image: String
    let lang: String
    let fileName: String
    let progress: Double
    let readingTime: Int
    let pageColorStyle: Int
    let fontName: String
    let textMargin: Double
    let linkColor: String
    let pageAlignment: Int
    let fontSize: Double
    let textSizeMultipler: Double
    let lineHeightMultiple: Double
    
    let textAlignment: Int
    let paragraphSpacing: Double
    let lineSpacing: Double
    let horizontalSpacing: Double
    let verticalSpacing: Double
    
    let readingChapter: Int
    let readingPage: Int
    let readingLocation: Int
    
    init(uid: String,
         title: String,
         image: String,
         lang: String,
         fileName: String,
         progress: Double,
         readingTime: Int,
         pageColorStyle: Int,
         fontName: String,
         textMargin: Double,
         linkColor: String,
         pageAlignment: Int,
         fontSize: Double,
         textSizeMultipler: Double,
         lineHeightMultiple: Double,
         paragraphSpacing: Double,
         lineSpacing: Double,
         textAlignment: Int,
         horizontalSpacing: Double,
         verticalSpacing: Double,
         readingChapter: Int,
         readingPage: Int,
         readingLocation: Int) {
        self.uid = uid
        self.title = title
        self.image = image
        self.lang = lang
        self.fileName = fileName
        self.progress = progress
        self.readingTime = readingTime
        
        self.pageColorStyle = pageColorStyle
        self.fontName = fontName
        self.textMargin = textMargin
        self.linkColor = linkColor
        self.pageAlignment = pageAlignment
        self.fontSize = fontSize
        self.textSizeMultipler = textSizeMultipler
        self.lineHeightMultiple = lineHeightMultiple

        self.textAlignment = textAlignment
        self.paragraphSpacing = paragraphSpacing
        self.lineSpacing = lineSpacing
        self.horizontalSpacing = horizontalSpacing
        self.verticalSpacing = verticalSpacing
        
        self.readingChapter = readingChapter
        self.readingPage = readingPage
        self.readingLocation = readingLocation
        
    }
}

extension Book {
    static var windowSize: CGSize = .zero
    
    var pageSize: CGSize {
        if Book.windowSize == .zero {
            return .zero
        }
        var resultRect = CGRect(origin: .zero, size: Book.windowSize)
        resultRect = resultRect.inset(by: UIEdgeInsets(top: verticalSpacing, left: horizontalSpacing, bottom: verticalSpacing, right: horizontalSpacing))
        return resultRect.size
    }
    var font: UIFont {
        return AvailableFont(rawValue: fontName)?.fontWithSize(fontSize + 15) ?? UIFont.systemFont(ofSize: fontSize)
    }
 
    var pageStyle: ReadingPageColorStyle {
        let style = ReadingPageColorStyle(rawValue: pageColorStyle) ?? .harmony
        return style
    }
    
    var alignment: NSTextAlignment {
        return NSTextAlignment(rawValue: textAlignment) ?? NSTextAlignment.left
    }
}

extension Book: RealmRepresentable {

    func asRealm() -> RMBook {
        let book = RMBook()
        book.uid = uid
        book.lang = lang
        book.image = image
        book.title = title
        book.fileName = fileName
        book.progress = progress
        book.readingTime = readingTime
        book.pageColorStyle = pageColorStyle
        book.fontName = fontName
        book.textMargin = textMargin
        book.linkColor = linkColor
        book.pageAlignment = pageAlignment
        book.fontSize = fontSize
        book.textSizeMultipler = textSizeMultipler
        book.lineHeightMultiple = lineHeightMultiple
        
        book.paragraphSpacing = paragraphSpacing
        book.lineSpacing = lineSpacing
        book.horizontalSpacing = horizontalSpacing
        book.verticalSpacing = verticalSpacing
        
        book.readingChapter = readingChapter
        book.readingPage = readingPage
        book.readingLocation = readingLocation
        return book
    }
}
