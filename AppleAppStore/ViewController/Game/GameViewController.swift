//
//  GameViewController.swift
//  AppleAppStore
//
//  Created by skillist on 2021/12/02.
//

import UIKit
import SnapKit

class GameViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        setupNavigationBar()
    }
    
    func setupNavigationBar() {
//        navigationItem.title = "game_title".localized
        navigationItem.title = "game_title".localized
        navigationController?.navigationBar.prefersLargeTitles = true
        //large title text 설정
        navigationController?.navigationBar.largeTitleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
        
        let accountProfileView = AccountProfileView()
        accountProfileView.clipsToBounds = true
        accountProfileView.backgroundColor = .systemBackground
        accountProfileView.layer.cornerRadius = 15
        navigationController?.navigationBar.addSubview(accountProfileView)
        accountProfileView.snp.makeConstraints {
            $0.trailing.equalToSuperview().inset(16)
            $0.bottom.equalToSuperview().inset(10)
            $0.width.height.equalTo(30)
        }
    }
}


//guard let navigationBar = self.navigationController?.navigationBar else { return }
//    navigationBar.addSubview(imageView)
//    imageView.layer.cornerRadius = Const.ImageSizeForLargeState / 2
//    imageView.clipsToBounds = true
//    imageView.translatesAutoresizingMaskIntoConstraints = false
//    NSLayoutConstraint.activate([
//        imageView.rightAnchor.constraint(equalTo: navigationBar.rightAnchor, constant: -Const.ImageRightMargin),
//        imageView.bottomAnchor.constraint(equalTo: navigationBar.bottomAnchor, constant: -Const.ImageBottomMarginForLargeState),
//        imageView.heightAnchor.constraint(equalToConstant: Const.ImageSizeForLargeState),
//        imageView.widthAnchor.constraint(equalTo: imageView.heightAnchor)
//        ])
