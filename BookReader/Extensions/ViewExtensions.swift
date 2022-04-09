//
//  ViewExtensions.swift
//  eMarket
//
//  Created by Nguyen Van Thanh on 2021/11/26.
//

import UIKit

extension UIView {
    ///
    /// Loads a view from nib.
    ///
    /// Please note that if you are assigning directly to an optinonal or unwrapped
    /// optional you have to specify `name` of the nib.
    ///
    class func loadFromNib<T>(_ name: String = String(describing: T.self), owner: AnyObject? = nil, options: [UINib.OptionsKey: Any]? = nil, bundle: Bundle? = Bundle.main) -> T {
        return UINib(nibName: name, bundle: bundle).instantiate(withOwner: owner, options: options).first as! T
    }
    
    class func loadFromNib<T>(_ name: String = String(describing: T.self), index: Int) -> T {
        return UINib(nibName: name, bundle: nil).instantiate(withOwner: nil, options: nil)[index] as! T
    }
}

protocol NibInstantiate {
    func instantiate()
}

extension NibInstantiate where Self: UIView {
    func instantiate() {
        let className = String(describing: type(of: self))
        let nib = UINib(nibName: className, bundle: nil)
        let view = nib.instantiate(withOwner: self, options: nil)[0] as! UIView
        view.frame = bounds
        addSubview(view)
    }
}

extension UIView {
    func addAndFitSubview(_ subView: UIView) {
        addSubview(subView)
        subView.translatesAutoresizingMaskIntoConstraints = false
        leadingAnchor.constraint(equalTo: subView.leadingAnchor).isActive = true
        trailingAnchor.constraint(equalTo: subView.trailingAnchor).isActive = true
        topAnchor.constraint(equalTo: subView.topAnchor).isActive = true
        bottomAnchor.constraint(equalTo: subView.bottomAnchor).isActive = true
    }
}
