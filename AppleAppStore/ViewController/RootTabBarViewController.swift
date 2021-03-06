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
        tabBar.barTintColor = .systemBackground
        tabBar.tintColor = .link
    }
    
    func setupTabBarItem() {
        let todayViewController = TodayCollectionViewController(collectionViewLayout: UICollectionViewFlowLayout())
        todayViewController.tabBarItem = UITabBarItem(
            title: "today_title".localized,
            image: UIImage(systemName: "doc.richtext"),
            selectedImage: UIImage(systemName: "doc.richtext.fill")
        )
        
        let appViewController = UINavigationController(rootViewController: AppViewController())
        appViewController.tabBarItem = UITabBarItem(
            title: "app_title".localized,
            image: UIImage(systemName: "gamecontroller"),
            selectedImage: UIImage(systemName: "gamecontroller.fill")
        )
        
        let searchViewController = UINavigationController(rootViewController: SearchViewController())
        searchViewController.tabBarItem = UITabBarItem(
            title: "search_title".localized,
            image: UIImage(systemName: "magnifyingglass"),
            selectedImage: UIImage(systemName: "magnifyingglass"))
        
        viewControllers = [
            todayViewController,
            appViewController,
            searchViewController
        ]
    }
}
