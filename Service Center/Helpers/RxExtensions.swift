//
//  RxExtensions.swift
//  Service Center
//
//  Created by Shahid Latif on 2019/10/14.
//  Copyright © 2019 MOHRE. All rights reserved.
//

import Foundation

import RxSwift
import RxCocoa

struct RxExtensions {
    
}

// SDWebImage reactive extension
import SDWebImage

extension Reactive where Base: UIImageView {
    func imageURL(withPlaceholder placeholderImage: UIImage?, options: SDWebImageOptions = [], progress: SDWebImageDownloaderProgressBlock? = nil) -> Binder<URL?> {
        return Binder(self.base) { imageView, url in
            imageView.sd_imageIndicator = SDWebImageActivityIndicator.large
            imageView.sd_setImage(with: url, placeholderImage: placeholderImage, options: options, progress: progress, completed: nil)
        }
    }
    
    var imageURL: Binder<URL?> {
        return self.imageURL(withPlaceholder: nil)
    }
}
