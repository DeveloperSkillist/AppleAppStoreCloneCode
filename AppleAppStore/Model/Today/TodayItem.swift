//
//  TodayItem.swift
//  AppleAppStore
//
//  Created by skillist on 2021/12/01.
//

import Foundation

struct TodayItem {
    let type: TodayItemType
    let items: [Any]
    var subText: String?
    var mainText: String?
}

enum TodayItemType: Int {
    case accountProfile
    case largeItem
    case smallItem
}
