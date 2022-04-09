//
//  ImageView.swift
//  eMarket
//
//  Created by Nguyen Van Thanh on 2021/11/27.
//

import UIKit

fileprivate let imagesCache = NSCache<NSString, UIImage>()

extension UIImageView {
    func setImage(from urlString: String, placeholder: UIImage? = UIImage(named: "iconEmpty")) {
        // 1. Check exists from cache
        if let cachedImg = imagesCache.object(forKey: NSString(string: urlString)) {
            self.image = cachedImg
            return
        }
        //2. if not exists load from url
        if let url = URL(string: urlString) {
            DispatchQueue.global().async { [weak self] in
                guard let imgData = try? Data(contentsOf: url),
                      var image = UIImage(data: imgData) else { return }
                // 3. Resize image to 80 to optimize performance and sure image quality is OK
                image = image.resizeImage(100.0, opaque: false)
                DispatchQueue.main.async {
                    //4. Caching the images, use url as key, image after resize
                   imagesCache.setObject(image, forKey: NSString(string: urlString))
                   self?.image = image
                }
            }
        }
        image = placeholder
    }
}
