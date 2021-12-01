//
//  AccountProfileView.swift
//  AppleAppStore
//
//  Created by skillist on 2021/12/01.
//

import UIKit
import SnapKit

class AccountProfileView: UIView {
    private lazy var profileView: DownloadableImageView = {
        let imageView = DownloadableImageView(frame: .zero)
        imageView.layer.cornerRadius = 10
        return imageView
    }()
    
    init() {
        super.init(frame: CGRect(x: 0, y: 0, width: 10, height: 10))
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupLayout() {
        addSubview(profileView)
        
        profileView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
}
