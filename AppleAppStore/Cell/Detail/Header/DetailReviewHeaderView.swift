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
    
    private lazy var reviewRateView: UIStackView = {
        var stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 5
        
        for starNum in 0...4 {
            var view = UIStackView()
            view.axis = .horizontal
            view.spacing = 10
            
            var starStr = ""
            for _ in 1...(5-starNum) {
                starStr.append("★")
            }
            let starView = UILabel()
            starView.text = starStr
            starView.textColor = .gray
            starView.textAlignment = .right
            starView.font = .systemFont(ofSize: 8)
            starView.snp.makeConstraints {
                $0.width.equalTo(55)
                $0.height.equalTo(10)
            }
            view.addArrangedSubview(starView)
            
            let progressView = UIProgressView()
            progressView.progressTintColor = .gray
            progressView.progress = .random(in: 0...1)
            progressView.snp.makeConstraints {
                $0.height.equalTo(5)
            }
            view.addArrangedSubview(progressView)
            
            stackView.addArrangedSubview(view)
        }
        return stackView
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
            $0.height.equalTo(80)
        }
        
        reviewRateView.snp.makeConstraints {
            $0.trailing.equalToSuperview()
            $0.centerY.equalTo(reviewRateText)
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
    }
    
    private func setupAction() {
        
    }
    
    func setupItem(rate: String, ratingCount: Int) {
        reviewRateText.text = rate
        reviewSmallText.text = "app_review_max_rate".localized
        reviewNumbersText.text = "\(ratingCount)" + "app_review_rate_count".localized
    }
}
