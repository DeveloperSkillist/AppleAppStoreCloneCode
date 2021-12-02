//
//  TodayListItemsBackgroundView.swift
//  AppleAppStore
//
//  Created by skillist on 2021/12/02.
//

import UIKit

class TodayListItemsBackgroundView: UICollectionReusableView {
    
    private lazy var backgroundView: UIView = {
        var view = UIView()
        view.backgroundColor = .lightGray
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
//        backgroundView.layer.maskedCorners = [CACornerMask.layerMinXMaxYCorner, CACornerMask.layerMaxXMaxYCorner]
        backgroundView.clipsToBounds = true
    }
}
