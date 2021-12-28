//
//  AppSmallItemCollectionHeaderView.swift
//  AppleAppStore
//
//  Created by skillist on 2021/12/03.
//

import UIKit

class AppSmallItemCollectionHeaderView: UICollectionReusableView {
    private lazy var lineView: UIView = {
        let view = UIView()
        view.backgroundColor = .darkGray
        return view
    }()
    
    private lazy var mainText: UILabel = {
        var label = UILabel()
        label.textColor = .label
        label.font = .systemFont(ofSize: 30, weight: .bold)
        label.numberOfLines = 2
        return label
    }()
    
    private lazy var headerButton: UIButton = {
        var button = UIButton()
        button.setTitle("show_all_title".localized, for: .normal)
        button.setTitleColor(.link, for: .normal)
        button.backgroundColor = .clear
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
            lineView,
            mainText,
            headerButton
        ].forEach {
            addSubview($0)
        }
        
        lineView.snp.makeConstraints {
            $0.top.equalToSuperview()
            $0.leading.trailing.equalToSuperview().inset(4)
            $0.height.equalTo(1)
        }
        
        mainText.snp.makeConstraints {
            $0.top.equalTo(lineView.snp.bottom).offset(5)
            $0.leading.equalTo(lineView)
            $0.bottom.equalToSuperview()
            $0.trailing.equalTo(headerButton.snp.leading).offset(-10)
        }
        
        headerButton.snp.makeConstraints {
            $0.centerY.equalTo(mainText)
            $0.trailing.equalTo(lineView)
        }
    }
    
    func setup(mainText: String?) {
        self.mainText.text = mainText
    }
}
