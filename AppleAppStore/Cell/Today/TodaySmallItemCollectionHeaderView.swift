//
//  TodaySmallItemCollectionViewCell.swift
//  AppleAppStore
//
//  Created by skillist on 2021/12/02.
//

import UIKit

class TodaySmallItemCollectionHeaderView: UICollectionReusableView {
    
    private lazy var subText: UILabel = {
        var label = UILabel()
        label.textColor = .darkGray
        label.font = .systemFont(ofSize: 20, weight: .semibold)
        return label
    }()
    
    private lazy var mainText: UILabel = {
        var label = UILabel()
        label.textColor = .label
        label.font = .systemFont(ofSize: 30, weight: .bold)
        label.numberOfLines = 2
        return label
    }()
    
    init() {
        super.init(frame: .zero)
        
        setupLayout()
    }
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupLayout() {
        [
            subText,
            mainText
        ].forEach {
            addSubview($0)
        }
        
        subText.snp.makeConstraints {
            $0.top.equalToSuperview().inset(36)
            $0.leading.trailing.equalToSuperview().inset(16)
        }
        
        mainText.snp.makeConstraints {
            $0.top.equalTo(subText.snp.bottom).offset(10)
            $0.leading.trailing.equalTo(subText)
            $0.bottom.equalToSuperview()
        }
    }
    
    func setup(mainText: String?, subText: String?) {
        self.mainText.text = mainText
        self.subText.text = subText
    }
}
