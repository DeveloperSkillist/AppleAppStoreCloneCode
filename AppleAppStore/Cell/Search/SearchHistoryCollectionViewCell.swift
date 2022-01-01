//
//  SearchHistoryCollectionViewCell.swift
//  AppleAppStore
//
//  Created by skillist on 2022/01/01.
//

import UIKit

class SearchHistoryCollectionViewCell: UICollectionViewCell {
    
    private lazy var historyLabel: UILabel = {
        var label = UILabel()
        label.textColor = .label
        return label
    }()
    
    private lazy var lineView: UIView = {
        let view = UIView()
        view.backgroundColor = .lightGray
        return view
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        [
            historyLabel,
            lineView
        ].forEach {
            addSubview($0)
        }
        
        historyLabel.snp.makeConstraints {
            $0.top.bottom.equalToSuperview()
            $0.left.trailing.equalToSuperview().inset(20)
            $0.height.equalTo(50)
        }
        
        lineView.snp.makeConstraints {
            $0.leading.equalTo(historyLabel)
            $0.trailing.bottom.equalToSuperview()
            $0.height.equalTo(1)
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupItem(historyString: String) {
        historyLabel.text = historyString
    }
}
