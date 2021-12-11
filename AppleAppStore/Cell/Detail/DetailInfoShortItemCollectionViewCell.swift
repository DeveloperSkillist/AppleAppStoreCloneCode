//
//  DetailInfoShortItemCollectionViewCell.swift
//  AppleAppStore
//
//  Created by skillist on 2021/12/11.
//

import UIKit

class DetailInfoShortItemCollectionViewCell: UICollectionViewCell {
    
    private lazy var topLabel: UILabel = {
        var label = UILabel()
        label.font = .systemFont(ofSize: 10)
        label.textColor = UIColor(named: "labelgray")
        label.textAlignment = .center
        return label
    }()
    
    private lazy var middleLabel: UILabel = {
        var label = UILabel()
        label.font = .systemFont(ofSize: 20, weight: .bold)
        label.textColor = UIColor(named: "labelgray")
        label.textAlignment = .center
        return label
    }()
    
    private lazy var bottomLabel: UILabel = {
        var label = UILabel()
        label.font = .systemFont(ofSize: 15, weight: .bold)
        label.textColor = UIColor(named: "labelgray")
        label.textAlignment = .center
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
        [
            topLabel,
            middleLabel,
            bottomLabel
        ].forEach {
            addSubview($0)
        }
        
        topLabel.snp.makeConstraints {
            $0.top.leading.trailing.equalToSuperview()
        }
        
        middleLabel.snp.makeConstraints {
            $0.top.equalTo(topLabel.snp.bottom).offset(10)
            $0.leading.trailing.equalTo(topLabel)
        }
        
        bottomLabel.snp.makeConstraints {
            $0.top.equalTo(middleLabel.snp.bottom).offset(10)
            $0.leading.trailing.equalTo(topLabel)
        }
        
        topLabel.text = "test"
        middleLabel.text = "asdqwe"
        bottomLabel.text = "q2314"
    }
}
