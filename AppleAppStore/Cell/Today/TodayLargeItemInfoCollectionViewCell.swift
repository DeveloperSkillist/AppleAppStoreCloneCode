//
//  TodayLargeItemInfoCollectionViewCell.swift
//  AppleAppStore
//
//  Created by skillist on 2021/12/01.
//

import UIKit
import SnapKit

class TodayLargeItemInfoCollectionViewCell: UICollectionViewCell {
    private lazy var subTitle: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.font = .systemFont(ofSize: 20)
        return label
    }()
    
    private lazy var mainTitle: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 30, weight: .semibold)
        label.numberOfLines = 0
        return label
    }()
    
    private lazy var bottomTitle: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 20)
        label.numberOfLines = 0
        return label
    }()
    
    private lazy var imageView: DownloadableImageView = {
        let imageView = DownloadableImageView(frame: .zero)
        imageView.contentMode = .scaleToFill
        imageView.backgroundColor = .white
        return imageView
    }()
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupLayout() {
        [
            imageView,
            subTitle,
            mainTitle,
            bottomTitle
        ].forEach {
            addSubview($0)
        }
        
        imageView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        
        subTitle.snp.makeConstraints {
            $0.top.equalToSuperview().inset(20)
            $0.leading.trailing.equalToSuperview().inset(20)
        }
        
        mainTitle.snp.makeConstraints {
            $0.top.equalTo(subTitle.snp.bottom).offset(10)
            $0.leading.trailing.equalTo(subTitle)
        }
        
        bottomTitle.snp.makeConstraints {
            $0.leading.trailing.equalTo(subTitle)
            $0.bottom.equalToSuperview().inset(20)
        }
        
        self.layer.cornerRadius = 15
        self.clipsToBounds = true
    }
    
    func setup(largeItem: LargeItem) {
        if let imageUrl = largeItem.imageURL {
            imageView.downloadImage(url: imageUrl)
        } else if let image = largeItem.image {
            imageView.image = image
        }
        
        subTitle.text = largeItem.subText
        mainTitle.text = largeItem.mainText
        bottomTitle.text = largeItem.bottomText
    }
}
