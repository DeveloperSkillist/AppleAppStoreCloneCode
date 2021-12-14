//
//  String+Extension.swift
//  AppleAppStore
//
//  Created by skillist on 2021/12/01.
//

import Foundation

extension String {
    
    //String 로컬라이즈
    var localized: String {
        return NSLocalizedString(self, tableName: "Localizable", value: self, comment: "")
    }
}
