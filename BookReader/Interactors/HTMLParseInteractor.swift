//
//  HTMLParseInteractor.swift
//  BookReader
//
//  Created by Nguyen Van Thanh on 2022/04/24.
//

import Foundation

class HTMLParseInteractor: NSObject {
    
    private let url: URL

    var totalLocation: Int {
        return currentString.count
    }
    private(set) var currentString = ""
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
    func parser(_ parser: AXHTMLParser, foundCharacters string: String, range: NSRange) {
        currentString += string
    }
}
