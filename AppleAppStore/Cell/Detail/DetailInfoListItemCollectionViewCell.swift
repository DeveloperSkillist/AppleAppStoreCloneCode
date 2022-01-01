//
//  DetailInfoListItemCollectionViewCell.swift
//  AppleAppStore
//
//  Created by skillist on 2021/12/30.
//

import UIKit

class DetailInfoInfoCollectionViewCell: UICollectionViewCell {
    
    var indexPath: IndexPath?
    weak var collectionViewLayoutUpdateDelegate: CollectionViewLayoutUpdateDelegate?
    let lineViewTag = 1
    
    private lazy var lineView: UIView = {
        let view = UIView()
        view.backgroundColor = .lightGray
        view.tag = lineViewTag
        return view
    }()
    
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
    
    override func prepareForReuse() {
        super.prepareForReuse()
        shortInfoLabel.isHidden = false
        moreButton.isHidden = false
        
        viewWithTag(lineViewTag)?.removeFromSuperview()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupAction()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupAction() {
        moreButton.addTarget(self, action: #selector(expandCell), for: .touchUpInside)
    }
    
    @objc private func expandCell() {
        if let indexPath = indexPath {
            collectionViewLayoutUpdateDelegate?.expandCell(indexPath: indexPath)
        }
        showDetailInfo()
    }
    
    private func showDetailInfo() {
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
    
    func setupItem(infoName: String, shortInfo: String, detailInfo: String?, isExpanded: Bool) {
        
        if let row = indexPath?.row, row > 0 {
            addLineView()
        }
        
        infoTitleLabel.text = infoName
        shortInfoLabel.text = shortInfo
        
        guard let detailInfo = detailInfo else {
            setupItem(infoName: infoName, shortInfo: shortInfo)
            return
        }
        detailInfoLabel.text = detailInfo
        
        setupItem(infoName: infoName, shortInfo: shortInfo, detailInfo: detailInfo)
        if isExpanded {
            showDetailInfo()
        }
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
        
        sizeToFit()
    }
    
    private func setupItem(infoName: String, shortInfo: String, detailInfo: String) {
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
        
        sizeToFit()
    }
    
    private func addLineView() {
        [
            lineView
        ].forEach {
            addSubview($0)
        }
        
        lineView.snp.makeConstraints {
            $0.top.leading.trailing.equalToSuperview()
            $0.height.equalTo(1)
        }
    }
}
