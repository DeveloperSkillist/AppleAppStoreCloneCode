//
//  ListItem.swift
//  AppleAppStore
//
//  Created by skillist on 2021/12/02.
//

import Foundation
import UIKit

struct ListItem {
    let mainText: String
    let subText: String
    let isInAppPurchase: Bool
    var isInstalled: Bool
    
    var imageURL: String?
    var image: UIImage?
}
