//
//  DTHTMLParserInteractor.swift
//  BookReader
//
//  Created by Nguyen Van Thanh on 2022/04/29.
//

import Foundation

class DTHTMLParserInteractor: NSObject {
    
    private let url: URL
    var totalLocation: Int {
        return currentString.count
    }
    private(set) var currentString = ""
    init(url: URL) {
        self.url = url
    }
    
    func parse() -> Bool {
        if let data = try? Data(contentsOf: url) {
            let parser = DTHTMLParser(data: data, encoding: String.Encoding.utf8.rawValue)!
            parser.delegate = self
            return parser.parse()
        }
        return false
    }
}

extension DTHTMLParserInteractor: DTHTMLParserDelegate {
    func parser(_ parser: DTHTMLParser, foundCharacters string: String) {
        currentString += string
    }
}
