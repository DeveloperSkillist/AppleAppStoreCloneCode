//
//  TodaySmallItemCollectionViewCell.swift
//  AppleAppStore
//
//  Created by skillist on 2021/12/01.
//

import UIKit
import SnapKit

class TodaySmallItemCollectionViewCell: UICollectionViewCell {
    private lazy var imageView: DownloadableImageView = {
        var imageView = DownloadableImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.layer.cornerRadius = 10
        imageView.backgroundColor = .label
        imageView.clipsToBounds = true
        return imageView
    }()
    
    private lazy var mainText: UILabel = {
        var label = UILabel()
        label.textColor = .label
        label.font = .systemFont(ofSize: 18, weight: .bold)
        label.numberOfLines = 2
        return label
    }()
    
    private lazy var subText: UILabel = {
        var label = UILabel()
        label.textColor = .darkGray
        label.font = .systemFont(ofSize: 15, weight: .semibold)
        return label
    }()
    
    private lazy var button: UIButton = {
        var button = UIButton()
        button.setTitle("down_title".localized, for: .normal)
        button.setTitleColor(.link, for: .normal)
        button.backgroundColor = UIColor(named: "lightgray,darkgray")
        button.layer.cornerRadius = 15
        return button
    }()
    
    private lazy var inAppPurchaseText: UILabel = {
        var label = UILabel()
        label.textColor = .darkGray
        label.font = .systemFont(ofSize: 13)
        return label
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
            mainText,
            subText,
            button,
            inAppPurchaseText
        ].forEach {
            addSubview($0)
        }
        
        imageView.snp.makeConstraints {
            $0.top.bottom.equalToSuperview().inset(5)
            $0.leading.equalToSuperview().inset(16)
            $0.width.height.equalTo(70)
        }
        
        button.snp.makeConstraints {
            $0.trailing.equalToSuperview().inset(16)
            $0.centerY.equalToSuperview()
            $0.width.equalTo(70)
        }
        
        inAppPurchaseText.snp.makeConstraints {
            $0.centerX.equalTo(button)
            $0.top.equalTo(button.snp.bottom)
            $0.bottom.equalToSuperview()
            $0.trailing.equalTo(button)
        }
        
        mainText.snp.makeConstraints {
            $0.top.equalTo(imageView).offset(5)
            $0.leading.equalTo(imageView.snp.trailing).offset(10)
            $0.trailing.equalTo(button.snp.leading).offset(-16)
        }
        
        subText.snp.makeConstraints {
            $0.top.equalTo(mainText.snp.bottom).offset(5)
            $0.leading.trailing.equalTo(mainText)
        }
    }
    
    func setup(item: TodaySmallItem) {
        mainText.text = item.mainText
        subText.text = item.subText
        inAppPurchaseText.text = "in_app_purchase".localized
        
        if let url = item.imageURL {
            imageView.downloadImage(url: url)
        } else if let image = item.image {
            imageView.image = image
        }
    }
}
