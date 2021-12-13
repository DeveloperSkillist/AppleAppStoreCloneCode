//
//  DetailReviewCollectionViewCell.swift
//  AppleAppStore
//
//  Created by skillist on 2021/12/13.
//

import UIKit

class DetailReviewCollectionViewCell: UICollectionViewCell {
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupLayout() {
        self.layer.cornerRadius = 10
        self.backgroundColor = UIColor(named: "lightgray,darkgray")
        
    }
}
