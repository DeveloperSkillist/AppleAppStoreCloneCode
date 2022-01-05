//
//  DetailLargeTitleWithButtonHeaderView.swift
//  AppleAppStore
//
//  Created by skillist on 2021/12/13.
//

import UIKit

class DetailLargeTitleWithButtonHeaderView: DetailLineHeaderView {
    
    lazy var largeTitleLabel: UILabel = {
        var label = UILabel()
        label.textColor = .label
        label.font = .systemFont(ofSize: 30, weight: .bold)
        return label
    }()
    
    lazy var largeButton: UIButton = {
        var button = UIButton()
        button.setTitleColor(.link, for: .normal)
        button.isHidden = true
        return button
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupLargeTitleLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupLargeTitleLayout() {
        lineView.snp.removeConstraints()
        lineView.snp.makeConstraints {
            $0.top.equalToSuperview()
            $0.leading.trailing.equalToSuperview().inset(2.5)
            $0.height.equalTo(1)
        }
        
        [
            largeTitleLabel,
            largeButton
        ].forEach {
            addSubview($0)
        }
        
        largeTitleLabel.snp.makeConstraints {
            $0.top.equalTo(lineView.snp.bottom).offset(10)
            $0.leading.equalTo(lineView)
            $0.trailing.equalTo(largeButton.snp.leading).offset(-10)
            $0.bottom.equalToSuperview()
            $0.height.equalTo(30)
        }
        
        largeButton.snp.makeConstraints {
            $0.trailing.equalTo(lineView)
            $0.centerY.equalTo(largeTitleLabel)
        }
    }
    
    func setupLargeTitleData(largeTitleText: String, largeButtonText: String?) {
        largeTitleLabel.text = largeTitleText
        if let buttonText = largeButtonText {
            largeButton.isHidden = false
            largeButton.setTitle(buttonText, for: .normal)
        }
    }
}
