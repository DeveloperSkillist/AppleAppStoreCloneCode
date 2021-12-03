//
//  AppLargeItemCollectionViewCell.swift
//  AppleAppStore
//
//  Created by skillist on 2021/12/03.
//

import UIKit
import SnapKit

class AppLargeItemCollectionViewCell: UICollectionViewCell {
    private lazy var lineView: UIView = {
        let view = UIView()
        view.backgroundColor = .darkGray
        return view
    }()
    
    private lazy var subTitle: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.font = .systemFont(ofSize: 15)
        label.textColor = .link
        return label
    }()
    
    private lazy var mainTitle: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 25, weight: .semibold)
        label.numberOfLines = 1
        label.textColor = .label
        return label
    }()
    
    private lazy var mainInfoTitle: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 25, weight: .semibold)
        label.numberOfLines = 1
        label.textColor = .label
        return label
    }()
    
    private lazy var imageView: DownloadableImageView = {
        let imageView = DownloadableImageView(frame: .zero)
        imageView.contentMode = .scaleAspectFill
        imageView.backgroundColor = UIColor(named: "white,darkgray")
        imageView.layer.cornerRadius = 15
        imageView.clipsToBounds = true
        return imageView
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
            lineView,
            subTitle,
            mainTitle,
            mainInfoTitle,
            imageView
        ].forEach {
            addSubview($0)
        }
        
        lineView.snp.makeConstraints {
            $0.top.trailing.equalToSuperview()
            $0.leading.equalToSuperview()
            $0.height.equalTo(1)
        }
        
        subTitle.snp.makeConstraints {
            $0.top.equalTo(lineView).inset(5)
            $0.leading.trailing.equalToSuperview()
        }
        
        mainTitle.snp.makeConstraints {
            $0.top.equalTo(subTitle.snp.bottom).offset(5)
            $0.leading.trailing.equalTo(subTitle)
        }
        
        mainInfoTitle.snp.makeConstraints {
            $0.top.equalTo(mainTitle.snp.bottom).offset(5)
            $0.leading.trailing.equalTo(subTitle)
        }
        
        imageView.snp.makeConstraints {
            $0.top.equalTo(mainInfoTitle.snp.bottom).offset(10)
            $0.leading.trailing.equalTo(subTitle)
            $0.height.lessThanOrEqualTo(self.frame.width * 0.7)
            $0.bottom.equalToSuperview().inset(5)
        }
    }
    
    func setup(item: AppLargeItem) {
        subTitle.text = item.subText
        subTitle.textColor = item.subTextColor
        
        mainTitle.text = item.mainText
        mainTitle.textColor = item.mainTextColor
        
        mainInfoTitle.text = item.mainInfoText
        mainInfoTitle.textColor = item.mainInfoTextColor
        
        if let url = item.imageURL {
            imageView.downloadImage(url: url)
        } else if let image = item.image {
            imageView.image = image
        }
    }
}
