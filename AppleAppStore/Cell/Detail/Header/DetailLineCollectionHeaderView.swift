//
//  DetailLineCollectionHeaderView.swift
//  AppleAppStore
//
//  Created by skillist on 2021/12/11.
//

import UIKit

class DetailLineCollectionHeaderView: UICollectionReusableView {
    lazy var lineView: UIView = {
        var lineView = UIView()
        lineView.backgroundColor = UIColor(named: "labelgray")
        return lineView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupLine()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupLine() {
        addSubview(lineView)
        lineView.snp.makeConstraints {
            $0.edges.equalToSuperview()
            $0.height.equalTo(1)
        }
    }
}
