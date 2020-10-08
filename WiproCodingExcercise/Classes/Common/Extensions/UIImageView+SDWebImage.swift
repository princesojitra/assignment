//
//  TableViewCell.swift
//  WiproCodingExcercise
//
//  Created by Prince Sojitra on 08/10/20.
//

import UIKit
import SDWebImage

extension UIImageView {
    
    // Image download and cache using SDWebImage
    func setImageWith(urlString: String, placeholder:UIImage?,imageIndicator:SDWebImageActivityIndicator, completion:((UIImage?, Error?) -> Void)?) {
        if let url = URL(string: urlString) {
            self.sd_imageIndicator = imageIndicator
            self.sd_setImage(with: url, placeholderImage: placeholder, options: .retryFailed, context: nil, progress: nil) { (img, error, cacheType, url) in
                if error != nil {
                    if placeholder == nil {
                        self.image =  UIImage(named: "placeholder")
                    } else {
                        self.image = placeholder
                    }
                }
                if completion != nil {
                    completion!(img, error)
                }
            }
        }else {
            self.image = placeholder ?? UIImage(named:"placeholder")
        }
    }
    
}
