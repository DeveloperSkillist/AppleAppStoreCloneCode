//
//  SearchResultAppCollectionViewCell.swift
//  AppleAppStore
//
//  Created by skillist on 2021/12/13.
//

import UIKit

class SearchResultAppCollectionViewCell: UICollectionViewCell {
    private lazy var iconView: DownloadableImageView = {
        var imageView = DownloadableImageView()
        imageView.contentMode = .scaleToFill
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
    
    private lazy var reviewText: UILabel = {
        var label = UILabel()
        label.textColor = .darkGray
        label.font = .systemFont(ofSize: 15, weight: .semibold)
        return label
    }()
    
    private lazy var textStackView: UIStackView = {
        var stackView = UIStackView()
        stackView.axis = .vertical
        stackView.distribution = .equalSpacing
        stackView.spacing = 5
        
        [
            mainText,
            subText,
            reviewText
        ].forEach {
            stackView.addArrangedSubview($0)
        }
        return stackView
    }()
    
    private lazy var screenShotImageView1: DownloadableImageView = {
        var imageView = DownloadableImageView()
        imageView.contentMode = .scaleToFill
        imageView.layer.cornerRadius = 10
        imageView.backgroundColor = .label
        imageView.clipsToBounds = true
        imageView.layer.borderWidth = 1
        imageView.layer.borderColor = UIColor.lightGray.cgColor
        return imageView
    }()
    
    private lazy var screenShotImageView2: DownloadableImageView = {
        var imageView = DownloadableImageView()
        imageView.contentMode = .scaleToFill
        imageView.layer.cornerRadius = 10
        imageView.backgroundColor = .label
        imageView.clipsToBounds = true
        imageView.layer.borderWidth = 1
        imageView.layer.borderColor = UIColor.lightGray.cgColor
        return imageView
    }()
    
    private lazy var screenShotImageView3: DownloadableImageView = {
        var imageView = DownloadableImageView()
        imageView.contentMode = .scaleToFill
        imageView.layer.cornerRadius = 10
        imageView.backgroundColor = .label
        imageView.clipsToBounds = true
        imageView.layer.borderWidth = 1
        imageView.layer.borderColor = UIColor.lightGray.cgColor
        return imageView
    }()
    
    private lazy var screenShotStackView: UIStackView = {
        var stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.distribution = .fillEqually
        stackView.spacing = 5
        stackView.backgroundColor = .blue
        [
            screenShotImageView1,
            screenShotImageView2,
            screenShotImageView3
        ].forEach {
            stackView.addArrangedSubview($0)
        }
        return stackView
    }()
    
    private lazy var appActionButton: UIButton = {
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
    
    private func setupLayout() {
        backgroundColor = .orange
        [
            iconView,
            textStackView,
            appActionButton,
            inAppPurchaseText,
            screenShotStackView
        ].forEach {
            addSubview($0)
        }
        
        iconView.snp.makeConstraints {
            $0.top.leading.equalToSuperview()
            $0.width.height.equalTo(70)
        }
        
        textStackView.snp.makeConstraints {
            $0.top.bottom.equalTo(iconView)
            $0.leading.equalTo(iconView.snp.trailing).offset(10)
            $0.trailing.equalTo(appActionButton.snp.leading).offset(-10)
        }
        
        appActionButton.snp.makeConstraints {
            $0.centerY.equalTo(iconView)
            $0.trailing.equalToSuperview()
            $0.width.equalTo(70)
        }
        
        inAppPurchaseText.snp.makeConstraints {
            $0.top.equalTo(appActionButton.snp.bottom).offset(5)
            $0.bottom.equalTo(iconView)
            $0.leading.trailing.equalTo(appActionButton)
            $0.centerX.equalTo(appActionButton)
        }

        screenShotStackView.snp.makeConstraints {
            $0.top.equalTo(iconView.snp.bottom).offset(10)
            $0.leading.equalTo(iconView)
            $0.trailing.equalTo(appActionButton)
            $0.bottom.equalToSuperview()
//            $0.height.equalTo(300)
        }
        setup()
    }
    
    func setup() {
        mainText.text = "테스트 앱"
        subText.text = "테스트 앱이거든요"
        reviewText.text = "9.1만"
        inAppPurchaseText.text = "in_app_purchase".localized
        
//        if let url = item.imageURL {
//            imageView.downloadImage(url: url)
//        } else if let image = item.image {
//            imageView.image = image
//        }
        
//        inAppPurchaseText.isHidden = !item.isInAppPurchase
    }
}
