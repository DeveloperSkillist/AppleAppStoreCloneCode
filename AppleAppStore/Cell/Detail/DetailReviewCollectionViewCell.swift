//
//  DetailReviewCollectionViewCell.swift
//  AppleAppStore
//
//  Created by skillist on 2021/12/13.
//

import UIKit

class DetailReviewCollectionViewCell: UICollectionViewCell {
    
    private lazy var reviewText: UILabel = {
        var label = UILabel()
        label.font = .systemFont(ofSize: 15)
        label.textColor = .label
        label.numberOfLines = 0
        label.textAlignment = .natural
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupLayout() {
        addSubview(reviewText)
        
        reviewText.snp.makeConstraints {
            $0.edges.equalToSuperview().inset(10)
        }
        
        self.layer.cornerRadius = 10
        self.backgroundColor = UIColor(named: "lightgray,darkgray")
    }
    
    func setupItem(text: String) {
        reviewText.text = "리뷰 영역입니다.\n하지만, 리뷰 관련 데이터가 없어,\ndevice 목록을 보여줍니다.\n\n\(text)"
    }
}
