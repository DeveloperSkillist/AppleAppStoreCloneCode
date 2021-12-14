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
        view.layer.cornerRadius = 15
        view.clipsToBounds = true
        
        view.layer.shadowColor = UIColor.black.cgColor
        view.layer.shadowOffset = .zero
        view.layer.shadowOpacity = 0.5
        view.layer.shadowRadius = 10
        view.layer.masksToBounds = false
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
    }
}
