//
//  AttributedTextPagingInteractor.swift
//  BookReader
//
//  Created by Nguyen Van Thanh on 2022/05/01.
//
import UIKit

class AttributedTextPagingInteractor {
    
    private var attributedString: NSAttributedString
    private var pageSize: CGSize

    init(attString: NSAttributedString, pageSize: CGSize) {
        self.attributedString = attString
        self.pageSize = pageSize
    }
    
    func getNextPageFromRange(_ range: NSRange) -> Page? {
        
        return nil
    }
    
    func getPrevPageToRange(_ range: NSRange) -> Page? {
        
        return nil
    }
}
