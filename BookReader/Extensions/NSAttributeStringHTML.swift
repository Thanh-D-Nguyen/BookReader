//
//  NSAttributeStringHTML.swift
//  BookReader
//
//  Created by Nguyen Van Thanh on 2022/04/24.
//

import Foundation

struct HTMLTag {
    let name: String
    let attributes: [String: String]

    var className: [String]? {
        guard let className = attributes["class"] else {
            return nil
        }
        return className.split(separator: " ").map { String($0) }
    }
}

private class HTMLParserDelegate: NSObject, AXHTMLParserDelegate {
    var attributedString: NSAttributedString?
    let handlers: [NSAttributedStringHTMLTagHandler]

    private var workingAttributedString: NSMutableAttributedString?
    private var workingElements = [(startIndex: Int, tag: HTMLTag)]()

    init(handlers: [NSAttributedStringHTMLTagHandler] = []) {
        self.handlers = handlers
    }

    func parserDidStartDocument(_ parser: AXHTMLParser) {
        workingAttributedString = NSMutableAttributedString()
    }

    func parserDidEndDocument(_ parser: AXHTMLParser) {
        attributedString = workingAttributedString
        workingAttributedString = nil
    }

    func parser(_ parser: AXHTMLParser, didStartElement elementName: String, attributes attributeDict: [AnyHashable: Any]) {
        let attributes = attributeDict as! [String: String]
        let startIndex = workingAttributedString!.length
        workingElements.append((startIndex, HTMLTag(name: elementName, attributes: attributes)))
    }

    func parser(_ parser: AXHTMLParser, didEndElement elementName: String) {
        let (startIndex, tag) = workingElements.removeLast()

        let subrange = NSRange(startIndex ..< workingAttributedString!.length)
        let replacementString: NSAttributedString = {
            let contents = workingAttributedString!.attributedSubstring(from: subrange)
            for handler in handlers {
                if let replacementString = handler(tag, contents) {
                    return replacementString
                }
            }

            return contents
        }()
        workingAttributedString!.replaceCharacters(in: subrange, with: replacementString)
    }

    func parser(_ parser: AXHTMLParser, foundCharacters string: String) {
        workingAttributedString!.append(NSAttributedString(string: string))
    }

    func parser(_ parser: AXHTMLParser, parseErrorOccurred parseError: Error) {
    }
}

typealias NSAttributedStringHTMLTagHandler = (_ tag: HTMLTag, _ contents: NSAttributedString) -> NSAttributedString?

extension NSAttributedString {
    convenience init?(htmlString: String, handlers: [NSAttributedStringHTMLTagHandler] = []) {
        guard let data = htmlString.data(using: .utf8) else {
            return nil
        }

        let stream = InputStream(data: data)
        let parser = AXHTMLParser(stream: stream)!

        let delegate = HTMLParserDelegate(handlers: handlers)
        parser.delegate = delegate

        guard parser.parse(), let attributedString = delegate.attributedString else {
            return nil
        }

        self.init(attributedString: attributedString)
    }
}
