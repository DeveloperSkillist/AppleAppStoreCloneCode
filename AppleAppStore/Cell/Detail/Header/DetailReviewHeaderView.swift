//
//  DetailReviewHeaderView.swift
//  AppleAppStore
//
//  Created by skillist on 2021/12/13.
//

import UIKit

class DetailReviewHeaderView: DetailLargeTitleHeaderView {
    
    private lazy var reviewRateText: UILabel = {
        var label = UILabel()
        label.font = .systemFont(ofSize: 80, weight: .bold)
        label.textColor = .label
        return label
    }()
    
    private lazy var reviewRateView: UIView = {
        var view = UIView()
        view.backgroundColor = .orange
        return view
    }()
    
    private lazy var reviewSmallText: UILabel = {
        var label = UILabel()
        label.font = .systemFont(ofSize: 20, weight: .bold)
        return label
    }()
    
    private lazy var reviewNumbersText: UILabel = {
        var label = UILabel()
        label.font = .systemFont(ofSize: 20)
        return label
    }()
        
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupReviewLayout()
        
        setupAction()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupReviewLayout() {
        largeTitleLabel.snp.removeConstraints()
        largeTitleLabel.snp.makeConstraints {
            $0.top.equalTo(lineView.snp.bottom).offset(10)
            $0.leading.equalToSuperview()
            $0.trailing.equalTo(largeButton.snp.leading).offset(-10)
            $0.height.equalTo(30)
        }
        
        [
            reviewRateText,
            reviewRateView,
            reviewSmallText,
            reviewNumbersText
        ].forEach {
            addSubview($0)
        }
                
        reviewRateText.snp.makeConstraints {
            $0.top.equalTo(largeTitleLabel.snp.bottom).offset(10)
            $0.leading.equalTo(largeTitleLabel)
            $0.trailing.equalTo(reviewRateView.snp.leading).offset(-10)
        }
        
        reviewRateView.snp.makeConstraints {
            $0.top.equalTo(reviewRateText)
            $0.trailing.equalToSuperview()
            $0.bottom.equalTo(reviewRateText)
        }
        
        reviewSmallText.snp.makeConstraints {
            $0.centerX.equalTo(reviewRateText)
            $0.top.equalTo(reviewRateText.snp.bottom)
            $0.bottom.equalToSuperview()
        }
        
        reviewNumbersText.snp.makeConstraints {
            $0.top.bottom.equalTo(reviewSmallText)
            $0.trailing.equalTo(reviewRateView)
        }
        
        setupItem()
    }
    
    private func setupAction() {
        
    }
    
    func setupItem() {
        reviewRateText.text = "4.5"
        reviewSmallText.text = "(최고 5점)"
        reviewNumbersText.text = "230개의 평가"
    }
}
