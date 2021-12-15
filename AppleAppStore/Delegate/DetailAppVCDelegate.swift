//
//  DetailAppVCDelegate.swift
//  AppleAppStore
//
//  Created by skillist on 2021/12/15.
//

import Foundation

protocol DetailAppVCDelegate: AnyObject {
    func pushDetailVC(item: SearchItemResult)
}
