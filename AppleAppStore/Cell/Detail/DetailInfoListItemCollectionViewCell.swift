//
//  DetailInfoListItemCollectionViewCell.swift
//  AppleAppStore
//
//  Created by skillist on 2021/12/30.
//

import UIKit

class DetailInfoInfoCollectionViewCell: UICollectionViewCell {
    
    weak var collectionViewLayoutUpdateDelegate: CollectionViewLayoutUpdateDelegate?
    
    private lazy var infoTitleLabel: UILabel = {
        var label = UILabel()
        label.textColor = .lightGray
        label.numberOfLines = 1
        label.backgroundColor = .systemBackground
        return label
    }()
    
    private lazy var shortInfoLabel: UILabel = {
        var label = UILabel()
        label.textColor = .label
        label.textAlignment = .right
        label.numberOfLines = 1
        label.backgroundColor = .systemBackground
        return label
    }()
    
    private lazy var moreButton: UIButton = {
        var button = UIButton()
        button.setTitle("", for: .normal)
        button.setImage(UIImage.init(systemName: "chevron.down"), for: .normal)
        button.tintColor = .black
        button.backgroundColor = .systemBackground
        return button
    }()
    
    private lazy var detailInfoLabel: UILabel = {
        var label = UILabel()
        label.textColor = .label
        label.numberOfLines = 0
        label.backgroundColor = .systemBackground
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupAction()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupItem(infoName: String, shortInfo: String) {
        [
            infoTitleLabel,
            shortInfoLabel
        ].forEach {
            addSubview($0)
        }
        
        infoTitleLabel.snp.makeConstraints {
            $0.top.bottom.equalToSuperview().inset(10)
            $0.leading.equalToSuperview()
            $0.height.equalTo(30)
            $0.width.equalTo(100)
        }
        
        shortInfoLabel.snp.makeConstraints {
            $0.top.bottom.equalTo(infoTitleLabel)
            $0.leading.equalTo(infoTitleLabel.snp.trailing).offset(10)
            $0.trailing.equalToSuperview()
        }
        
        infoTitleLabel.text = infoName
        shortInfoLabel.text = shortInfo
        
        sizeToFit()
    }
    
    func setupItem(infoName: String, shortInfo: String, detailInfo: String?) {
        if detailInfo == nil {
            setupItem(infoName: infoName, shortInfo: shortInfo)
            return
        }
        
        [
            infoTitleLabel,
            shortInfoLabel,
            moreButton
        ].forEach {
            addSubview($0)
        }
        
        infoTitleLabel.snp.makeConstraints {
            $0.top.bottom.equalToSuperview().inset(10)
            $0.leading.equalToSuperview()
            $0.height.equalTo(30)
            $0.width.equalTo(100)
        }
        
        shortInfoLabel.snp.makeConstraints {
            $0.top.bottom.equalTo(infoTitleLabel)
            $0.leading.equalTo(infoTitleLabel.snp.trailing).offset(10)
        }
        
        moreButton.snp.makeConstraints {
            $0.top.equalTo(infoTitleLabel)
            $0.leading.equalTo(shortInfoLabel.snp.trailing).offset(10)
            $0.trailing.equalToSuperview()
            $0.bottom.equalTo(infoTitleLabel)
            $0.width.equalTo(30)
        }
        
        infoTitleLabel.text = infoName
        shortInfoLabel.text = shortInfo
        detailInfoLabel.text = detailInfo
        
        sizeToFit()
    }
    
    private func setupAction() {
        moreButton.addTarget(self, action: #selector(showDetailInfo), for: .touchUpInside)
    }
    
    @objc private func showDetailInfo() {
        shortInfoLabel.isHidden = true
        moreButton.isHidden = true
        
        addSubview(detailInfoLabel)
        
        infoTitleLabel.snp.removeConstraints()
        infoTitleLabel.snp.makeConstraints {
            $0.top.equalToSuperview().inset(10)
            $0.leading.equalToSuperview()
            $0.height.equalTo(30)
            $0.width.equalTo(100)
        }
        
        detailInfoLabel.snp.makeConstraints {
            $0.top.equalTo(infoTitleLabel.snp.bottom)
            $0.leading.equalTo(infoTitleLabel)
            $0.trailing.equalToSuperview()
            $0.bottom.equalToSuperview().inset(10)
        }
        
        collectionViewLayoutUpdateDelegate?.collectionViewLayoutUpdate()
    }
}
