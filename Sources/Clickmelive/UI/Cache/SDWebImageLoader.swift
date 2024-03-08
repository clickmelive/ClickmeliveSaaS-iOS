//
//  SDWebImageLoader.swift
//  Clickmelive
//
//  Created by Can on 5.03.2024.
//

import UIKit
import SDWebImage

final class SDWebImageLoader: ImageLoader {
    func loadImage(to imageView: UIImageView, with url: URL?, placeholder: UIImage?) {
        imageView.sd_imageTransition = .fade
        imageView.sd_setImage(with: url, placeholderImage: placeholder, completed: {_,_,_,_ in
            imageView.sd_imageTransition = nil
        })
    }
}
