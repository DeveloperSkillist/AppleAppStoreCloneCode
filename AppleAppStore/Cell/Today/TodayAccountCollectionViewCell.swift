//
//  TodayAccountCollectionViewCell.swift
//  AppleAppStore
//
//  Created by skillist on 2021/12/01.
//

import UIKit
import SnapKit

class TodayAccountCollectionViewCell: UICollectionViewCell {
    private lazy var dateLabel: UILabel = {
        let label = UILabel()
        label.textColor = .darkGray
        label.font = .systemFont(ofSize: 15, weight: .semibold)
        return label
    }()
    
    private lazy var largeTitle: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.font = .systemFont(ofSize: 34, weight: .bold)
        return label
    }()
    
    private lazy var accountProfileView = AccountProfileView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupLayout() {
        [
            dateLabel,
            largeTitle,
            accountProfileView
        ].forEach {
            addSubview($0)
        }
        
        dateLabel.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview().inset(16)
            $0.bottom.equalTo(largeTitle.snp.top)
        }
        
        largeTitle.snp.makeConstraints {
            $0.leading.equalTo(dateLabel)
            $0.bottom.equalTo(self.snp.bottom).inset(8)
        }
        
        accountProfileView.snp.makeConstraints {
            $0.trailing.equalTo(dateLabel)
            $0.bottom.equalToSuperview().inset(10)
            $0.width.height.equalTo(30)
        }
        accountProfileView.layer.cornerRadius = 15
        accountProfileView.clipsToBounds = true
        
        dateLabel.text = getCurrentDate
        largeTitle.text = "today_title".localized
    }
    
    var getCurrentDate: String {
        let dataFormatter = DateFormatter()
        dataFormatter.dateFormat = "MM. dd. E"
        dataFormatter.locale = Locale(identifier: "ko")
        return dataFormatter.string(from: Date())
    }
}
