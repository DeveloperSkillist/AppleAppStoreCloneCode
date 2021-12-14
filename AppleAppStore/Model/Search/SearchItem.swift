//
//  SearchItem.swift
//  AppleAppStore
//
//  Created by skillist on 2021/12/13.
//

import Foundation

struct SearchItem {
    var itemType: SearchItemType
    var item: Any
}

enum SearchItemType {
    case app
    case etc
}
