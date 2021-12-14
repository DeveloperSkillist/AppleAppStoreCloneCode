//
//  DetailTextInfoCollectionViewCell.swift
//  AppleAppStore
//
//  Created by skillist on 2021/12/11.
//

import UIKit

class DetailTextInfoCollectionViewCell: UICollectionViewCell {
    
    weak var collectionViewLayoutUpdateDelegate: CollectionViewLayoutUpdateDelegate?
    
    private lazy var detailLabel: UILabel = {
        var label = UILabel()
        label.textColor = .label
        label.numberOfLines = 3
        label.backgroundColor = .systemBackground
        return label
    }()
    
    private lazy var moreButton: UIButton = {
        var button = UIButton()
        button.setTitleColor(.link, for: .normal)
        return button
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupLayout()
        setupAction()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupLayout() {
        [
            detailLabel,
            moreButton
        ].forEach {
            addSubview($0)
        }
        
        detailLabel.snp.makeConstraints {
            $0.top.leading.trailing.equalToSuperview()
            $0.bottom.equalToSuperview()
        }
        
        moreButton.snp.makeConstraints {
            $0.trailing.bottom.equalTo(detailLabel)
        }
        detailLabel.text = "1\n2\n3\n4\n5\n6\n7\n8"
        moreButton.setTitle("더 보기", for: .normal)
        
        sizeToFit()
    }
    
    private func setupAction() {
        moreButton.addTarget(self, action: #selector(showAllDetailInfo), for: .touchUpInside)
    }
    
    @objc private func showAllDetailInfo() {
        detailLabel.numberOfLines = 0
        moreButton.isHidden = true
        
        collectionViewLayoutUpdateDelegate?.collectionViewLayoutUpdate()
    }
}
