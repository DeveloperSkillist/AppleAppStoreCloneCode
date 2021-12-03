//
//  TodaySmallItemBackgroundView.swift
//  AppleAppStore
//
//  Created by skillist on 2021/12/02.
//

import UIKit

class TodaySmallItemBackgroundView: UICollectionReusableView {
    
    private lazy var backgroundView: UIView = {
        var view = UIView()
        view.backgroundColor = UIColor(named: "white,darkgray")
        return view
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupLayout() {
        addSubview(backgroundView)
        
        backgroundView.snp.makeConstraints {
            $0.edges.equalToSuperview()
                .inset(16)
        }
        backgroundView.layer.cornerRadius = 15
        backgroundView.clipsToBounds = true
        
        backgroundView.layer.shadowColor = UIColor.black.cgColor
        backgroundView.layer.shadowOffset = .zero
        backgroundView.layer.shadowOpacity = 0.5
        backgroundView.layer.shadowRadius = 10
        backgroundView.layer.masksToBounds = false
    }
}
