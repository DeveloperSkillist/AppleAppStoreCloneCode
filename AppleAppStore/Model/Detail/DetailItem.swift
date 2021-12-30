//
//  DetailItem.swift
//  AppleAppStore
//
//  Created by skillist on 2021/12/11.
//

import Foundation

struct DetailItem {
    var itemType: DetailSection
    var items: [Any]?
    var headerType: DetailSectionHeaderType
}

enum DetailSection: Int {
    case main
    case infoShortItem
    case screenShots
    case textDescription
    case textInfo
    case review
    case newFeatureInfo
    case infoListItem
}

enum DetailSectionHeaderType {
    case line
    case largeTitleWithButton
    case review
    case none
}
