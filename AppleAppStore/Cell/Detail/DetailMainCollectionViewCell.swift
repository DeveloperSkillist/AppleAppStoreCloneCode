//
//  DetailMainCollectionViewCell.swift
//  AppleAppStore
//
//  Created by skillist on 2021/12/11.
//

import UIKit

class DetailMainCollectionViewCell: UICollectionViewCell {
    
    private lazy var imageView: DownloadableImageView = {
        var imageView = DownloadableImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.layer.cornerRadius = 15
        imageView.layer.borderWidth = 1
        imageView.layer.borderColor = UIColor.darkGray.cgColor
        imageView.clipsToBounds = true
        return imageView
    }()
    
    private lazy var titleLabel: UILabel = {
        var label = UILabel()
        label.font = .systemFont(ofSize: 20, weight: .bold)
        label.textColor = .label
        return label
    }()
    
    private lazy var infoLabel: UILabel = {
        var label = UILabel()
        label.font = .systemFont(ofSize: 15, weight: .bold)
        label.textColor = UIColor(named: "labelgray")
        return label
    }()
    
    private lazy var appActionButton: UIButton = {
        var button = UIButton()
        button.setTitle("app_download_title".localized, for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = .link
        button.layer.cornerRadius = 15
        return button
    }()
    
    private lazy var inAppPurchaseLabel: UILabel = {
        var label = UILabel()
        label.text = "in_app_purchase".localized
        label.font = .systemFont(ofSize: 10)
        return label
    }()
    
    private lazy var shareButton: UIButton = {
        var button = UIButton()
        button.setTitle(nil, for: .normal)
        button.setImage(UIImage(systemName: "square.and.arrow.up"), for: .normal)
        button.tintColor = .link
//        button.backgroundColor = .gray
        return button
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
            imageView,
            titleLabel,
            infoLabel,
            appActionButton,
            inAppPurchaseLabel,
            shareButton
        ].forEach {
            addSubview($0)
        }
        
        imageView.snp.makeConstraints {
            $0.top.leading.bottom.equalToSuperview()
            $0.width.equalTo(imageView.snp.height)
        }
        
        if UIDevice.current.userInterfaceIdiom == .pad {
            shareButton.snp.makeConstraints {
                $0.trailing.equalToSuperview()
                $0.top.equalTo(titleLabel).offset(5)
            }
            
            titleLabel.snp.makeConstraints {
                $0.top.equalTo(imageView)
                $0.leading.equalTo(imageView.snp.trailing).offset(10)
                $0.trailing.equalTo(shareButton.snp.leading).offset(-10)
            }
        } else {
            shareButton.snp.makeConstraints {
                $0.trailing.equalToSuperview()
                $0.centerY.equalTo(appActionButton)
            }
            
            titleLabel.snp.makeConstraints {
                $0.top.equalTo(imageView)
                $0.leading.equalTo(imageView.snp.trailing).offset(10)
                $0.trailing.equalToSuperview().offset(-10)
            }
        }
        
        infoLabel.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom).offset(5)
            $0.leading.trailing.equalTo(titleLabel)
        }
        
        appActionButton.snp.makeConstraints {
            $0.leading.equalTo(imageView.snp.trailing).offset(10)
            $0.bottom.equalToSuperview()
            $0.width.equalTo(70)
        }
        
        inAppPurchaseLabel.snp.makeConstraints {
            $0.centerY.equalTo(appActionButton)
            $0.leading.equalTo(appActionButton.snp.trailing).offset(5)
        }
        
        titleLabel.sizeToFit()
        titleLabel.text = "tempfjhghjg\nasd"
        infoLabel.text = "infoqweuiouwqioiofjsdlk"
    }
}
