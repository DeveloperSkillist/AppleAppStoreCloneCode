//
//  AppItem.swift
//  AppleAppStore
//
//  Created by skillist on 2021/12/03.
//

import Foundation

struct AppItem {
    let type: AppItemType
    let items: [Any]
    var subText: String?
    var mainText: String?
    var mainInfoText: String?
    var isAllShowButton: Bool?
}

enum AppItemType: Int {
    case LargeItem
    case MediumItem
    case SmallItem
}
