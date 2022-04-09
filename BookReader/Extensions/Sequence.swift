//
//  Sequence.swift
//  KinhLangNghiemMVP
//
//  Created by Nguyen Van Thanh on 2022/03/27.
//

import Foundation

extension Sequence  {
    func sum<T: AdditiveArithmetic>(_ predicate: (Element) -> T) -> T { reduce(.zero) { $0 + predicate($1) } }
}
