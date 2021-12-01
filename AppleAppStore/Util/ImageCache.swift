//
//  ImageCache.swift
//  AppleAppStore
//
//  Created by skillist on 2021/12/01.
//

import UIKit

//이미지 캐시
class ImageCache {
    static let shared = NSCache<NSString, UIImage>()
}
