//
//  TodayAccountCollectionViewCell.swift
//  AppleAppStore
//
//  Created by skillist on 2021/12/01.
//

import UIKit
import SnapKit

class TodayAccountCollectionViewCell: UICollectionViewCell {
    private lazy var dateLabel: UILabel = {
        let label = UILabel()
        label.textColor = .darkGray
        label.font = .systemFont(ofSize: 10)
        return label
    }()
    
    private lazy var largeTitle: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.font = .systemFont(ofSize: 15, weight: .bold)
        return label
    }()
    
    private lazy var accountProfileView = AccountProfileView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupLayout() {
        [
            dateLabel,
            largeTitle,
            accountProfileView
        ].forEach {
            addSubview($0)
        }
        
        dateLabel.snp.makeConstraints {
            $0.top.leading.trailing.equalToSuperview().inset(10)
        }
        
        largeTitle.snp.makeConstraints {
            $0.top.equalTo(dateLabel.snp.bottom).offset(10)
            $0.leading.equalTo(dateLabel)
        }
        
        accountProfileView.snp.makeConstraints {
            $0.trailing.equalToSuperview().offset(-10)
            
        }
    }
}
