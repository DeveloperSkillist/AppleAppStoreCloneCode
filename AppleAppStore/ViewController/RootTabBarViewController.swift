//
//  RottTabBarViewController.swift
//  AppleAppStore
//
//  Created by skillist on 2021/12/01.
//

import UIKit

class RootTabBarViewController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()

        setupTabBar()
        setupTabBarItem()
    }
    
    func setupTabBar() {
        tabBar.barTintColor = .darkGray
    }
    
    func setupTabBarItem() {
        
        let layout = UICollectionViewFlowLayout()
        let todayViewController = TodayViewController(collectionViewLayout: layout)
        todayViewController.tabBarItem = UITabBarItem(
            title: "투데이",
            image: UIImage(systemName: "doc.richtext"),
            selectedImage: UIImage(systemName: "doc.richtext.fill")
        )
        
        viewControllers = [todayViewController]
    }
}
