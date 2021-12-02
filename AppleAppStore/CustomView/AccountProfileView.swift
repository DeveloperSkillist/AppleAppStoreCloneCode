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
        imageView.backgroundColor = .label
        imageView.image = UIImage(named: "AppIcon")
        return imageView
    }()
    
    init() {
        super.init(frame: .zero)
        
        setupLayout()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupLayout() {
        self.backgroundColor = .label
        self.layer.cornerRadius = self.layer.frame.height/2
        
        addSubview(profileView)
        
        profileView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
}
