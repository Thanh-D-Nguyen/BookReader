//
//  HTMLParseInteractor.swift
//  BookReader
//
//  Created by Nguyen Van Thanh on 2022/04/24.
//

import Foundation

struct HTMLAttributeItem {
    var name: String
    var attributes: [String: String]
}

class HTMLParseInteractor: NSObject {
    
    private let url: URL
    private var elements: [HTMLAttributeItem] = []

    private(set) var totalLocation: UInt = 0
    private(set) var currentString = ""
    private(set) var attributes: [NSRange: [HTMLAttributeItem]] = [:]

    init(url: URL) {
        self.url = url
    }
    
    func parse() -> Bool {
        let stream = InputStream(fileAtPath: url.path)
        let parser = AXHTMLParser(stream: stream)!
        parser.delegate = self
        return parser.parse()
    }
}

extension HTMLParseInteractor: AXHTMLParserDelegate {
    
    func parser(_ parser: AXHTMLParser!, foundCharacters string: String!, range: NSRange) {
        if attributes[range] != nil {
            var items = attributes[range]!
            items.append(contentsOf: elements)
            attributes[range] = items
        } else {
            attributes[range] = elements
        }
        currentString += string
    }
    
    func parser(_ parser: AXHTMLParser!, didStartElement elementName: String!, attributes attributeDict: [AnyHashable : Any]! = [:]) {
        let item = HTMLAttributeItem(name: elementName, attributes: attributeDict as! [String: String])
        elements.append(item)
    }
    
    func parser(_ parser: AXHTMLParser!, didEndElement elementName: String!) {
        if let index = elements.firstIndex(where: { $0.name == elementName }) {
            elements.remove(at: index)
        }
    }
    
    func parserDidStartDocument(_ parser: AXHTMLParser!) {
        elements.removeAll()
    }
    
    func parserDidEndDocument(_ parser: AXHTMLParser!, length len: UInt) {
        totalLocation = len
        elements.removeAll()
    }
}
