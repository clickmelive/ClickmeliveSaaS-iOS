//
//  ImageLoader.swift
//  ClickmeliveUI
//
//  Created by Can on 3.03.2024.
//

import UIKit

protocol ImageLoader {
    func loadImage(to imageView: UIImageView, with url: URL?, placeholder: UIImage?)
}
