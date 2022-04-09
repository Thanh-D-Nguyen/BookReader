//
//  RMBook.swift
//  KinhLangNghiemVIP
//
//  Created by Nguyen Van Thanh on 2022/01/15.
//

import RealmSwift
import Realm

final class RMBook: Object {

    @objc dynamic var title: String = ""
    @objc dynamic var uid: String = ""
    @objc dynamic var image: String = ""
    @objc dynamic var lang: String = ""
    @objc dynamic var fileName: String = ""
    @objc dynamic var progress: Double = 0.0
    
    @objc dynamic var readingTime: Int = 0
    
    @objc dynamic var pageColorStyle: Int = 1
    @objc dynamic var fontName: String = ""
    @objc dynamic var textMargin: Double = 0
    @objc dynamic var linkColor: String = ""
    @objc dynamic var pageAlignment: Int = 0
    @objc dynamic var fontSize: Double = 13
    @objc dynamic var textSizeMultipler: Double = 12
    @objc dynamic var lineHeightMultiple: Double = 1.1
    
    @objc dynamic var textAligment: Int = NSTextAlignment.left.rawValue
    @objc dynamic var paragraphSpacing: Double = 10
    @objc dynamic var lineSpacing: Double = 2
    @objc dynamic var horizontalSpacing: Double = 26
    @objc dynamic var verticalSpacing: Double = 40
    
    @objc dynamic var readingChapter: Int = 0
    @objc dynamic var readingPage: Int = 0
    @objc dynamic var readingLocation: Int = 0
    
    override class func primaryKey() -> String? {
        return "uid"
    }
}

extension RMBook: DomainConvertibleType {
    func asDomain() -> Book {
        return Book(uid: uid,
                    title: title,
                    image: image,
                    lang: lang,
                    fileName: fileName,
                    progress: progress,
                    readingTime: readingTime,
                    pageColorStyle: pageColorStyle,
                    fontName: fontName,
                    textMargin: textMargin,
                    linkColor: linkColor,
                    pageAlignment: pageAlignment,
                    fontSize: fontSize,
                    textSizeMultipler: textSizeMultipler,
                    lineHeightMultiple: lineHeightMultiple,
                    paragraphSpacing: paragraphSpacing,
                    lineSpacing: lineSpacing,
                    textAlignment: textAligment,
                    horizontalSpacing: horizontalSpacing,
                    verticalSpacing: verticalSpacing,
                    readingChapter: readingChapter,
                    readingPage: readingPage,
                    readingLocation: readingLocation)
    }
}
