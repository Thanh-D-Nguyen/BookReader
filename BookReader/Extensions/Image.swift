//
//  Image.swift
//  KinhLangNghiemMVP
//
//  Created by Nguyen Van Thanh on 2022/02/24.
//

import UIKit

extension UIImage {
    func resizeImage(maxWidth: CGFloat) -> UIImage {
        let aspectRatio =  size.width / size.height
        let height = maxWidth / aspectRatio
        var newImage: UIImage
        let renderFormat = UIGraphicsImageRendererFormat.default()
        let renderer = UIGraphicsImageRenderer(size: CGSize(width: maxWidth, height: height), format: renderFormat)
        newImage = renderer.image {
            (context) in
            self.draw(in: CGRect(x: 0, y: 0, width: maxWidth, height: height))
        }
        return newImage
    }

    func resizeImage(_ dimension: CGFloat, opaque: Bool) -> UIImage {
        var width: CGFloat
        var height: CGFloat
        var newImage: UIImage
        let size = self.size
        let aspectRatio =  size.width / size.height
        if aspectRatio > 1 {
            width = dimension
            height = dimension / aspectRatio
        } else {
            height = dimension
            width = dimension * aspectRatio
        }
        let renderFormat = UIGraphicsImageRendererFormat.default()
        renderFormat.opaque = opaque
        let renderer = UIGraphicsImageRenderer(size: CGSize(width: width, height: height), format: renderFormat)
        newImage = renderer.image {
            (context) in
            self.draw(in: CGRect(x: 0, y: 0, width: width, height: height))
        }
        return newImage
    }
    
    class func circle(diameter: CGFloat, color: UIColor) -> UIImage {
        UIGraphicsBeginImageContextWithOptions(CGSize(width: diameter, height: diameter), false, 0)
        let ctx = UIGraphicsGetCurrentContext()!
        ctx.saveGState()
        let rect = CGRect(x: 0, y: 0, width: diameter, height: diameter)
        ctx.setFillColor(color.cgColor)
        ctx.fillEllipse(in: rect)
        ctx.restoreGState()
        let img = UIGraphicsGetImageFromCurrentImageContext()!
        UIGraphicsEndImageContext()
        
        return img
    }
}
