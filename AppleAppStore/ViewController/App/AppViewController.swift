//
//  AppViewController.swift
//  AppleAppStore
//
//  Created by skillist on 2021/12/02.
//

import UIKit
import SnapKit

class AppViewController: UIViewController {
    
    private lazy var layout: UICollectionViewLayout = {
        return UICollectionViewCompositionalLayout { [weak self] section, _ -> NSCollectionLayoutSection? in
            switch self?.items[section].type {
            case .LargeItem:
                return self?.createLargeItemSection()
            case .MediumItem:
//                return self?.createMediumItemInfoSection()
                return nil
            case .SmallItem:
                return self?.createSmallItemSection()
            default:
                return nil
            }
        }
    }()

    private lazy var collectionView: UICollectionView = {
        var collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.delegate = self
        collectionView.dataSource = self
        
        
        collectionView.register(AppLargeItemCollectionViewCell.self, forCellWithReuseIdentifier: "AppLargeItemCollectionViewCell")
        
        collectionView.register(AppSmallItemsCollectionViewCell.self, forCellWithReuseIdentifier: "AppSmallItemsCollectionViewCell")
        return collectionView
    }()
    
    private var items: [AppItem] = []
    let margin: CGFloat = 16
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupNavigationBar()
        setupLayout()
        setupItems()
    }
    
    private func setupNavigationBar() {
        view.backgroundColor = .systemBackground
        navigationItem.title = "app_title".localized
        navigationController?.navigationBar.prefersLargeTitles = true
        //large title text 설정
        navigationController?.navigationBar.largeTitleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.label]
        
        let accountProfileView = AccountProfileView()
        accountProfileView.clipsToBounds = true
        accountProfileView.backgroundColor = .label
        accountProfileView.layer.cornerRadius = 15
        navigationController?.navigationBar.addSubview(accountProfileView)
        accountProfileView.snp.makeConstraints {
            $0.trailing.equalToSuperview().inset(16)
            $0.bottom.equalToSuperview().inset(10)
            $0.width.height.equalTo(30)
        }
    }
    
    private func setupLayout() {
        [
            collectionView
        ].forEach {
            view.addSubview($0)
        }
        
        collectionView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
    
    private func setupItems() {
        items = [
            AppItem(
                type: .LargeItem,
                items: [
                    AppLargeItem(
                        subText: "2021 App Store Awards",
                        mainText: "App Store Awards",
                        mainInfoText: "수상작을 소개합니다",
                        subTextColor: .link,
                        mainTextColor: .white,
                        mainInfoTextColor: .white,
                        imageURL: nil,
                        image: UIImage(named: "orange_skillist")
                    ),
                    AppLargeItem(
                        subText: "2021 App Store Awards",
                        mainText: "Skillist Project",
                        mainInfoText: "이게 스터디다",
                        subTextColor: .link,
                        mainTextColor: .white,
                        mainInfoTextColor: .white,
                        imageURL: nil,
                        image: UIImage(named: "pink_skillist")
                    ),
                    AppLargeItem(
                        subText: "2021 App Store Awards",
                        mainText: "Skillist Project",
                        mainInfoText: "이것이 클론코딩이다",
                        subTextColor: .link,
                        mainTextColor: .white,
                        mainInfoTextColor: .white,
                        imageURL: nil,
                        image: UIImage(named: "blue_skillist")
                    )
                ],
                subText: "",
                mainText: "",
                mainInfoText: ""
            )
        ]
    }
}

extension AppViewController {
    private func createLargeItemSection() -> NSCollectionLayoutSection {
        let itemMargin: CGFloat = 4
        
        //item
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(1))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
//        item.contentInsets = .init(top: 0, leading: margin/2, bottom: 0, trailing: margin/2)
        
        //group
        let groupSize = NSCollectionLayoutSize(widthDimension: .absolute(collectionView.frame.width - (itemMargin * 2)), heightDimension: .estimated(350))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitem: item, count: 1)
        group.contentInsets = .init(top: 0, leading: itemMargin, bottom: 0, trailing: itemMargin)
        
        //section
        let section = NSCollectionLayoutSection(group: group)
        section.orthogonalScrollingBehavior = .paging
        section.contentInsets = .init(top: margin, leading: itemMargin*2, bottom: margin, trailing: itemMargin*2)
        
        return section
    }
    
    private func createSmallItemSection() -> NSCollectionLayoutSection {
        //아이템
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(1))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        
        //group
        let groupSize = NSCollectionLayoutSize(widthDimension: .absolute(collectionView.frame.size.width - 32), heightDimension: .estimated(310))
        let group = NSCollectionLayoutGroup.vertical(layoutSize: groupSize, subitem: item, count: 4)
        
        //section
        let section = NSCollectionLayoutSection(group: group)
        section.orthogonalScrollingBehavior = .none
        section.contentInsets = .init(top: margin, leading: margin, bottom: margin + 30, trailing: margin)
        
        //TODO header
//        let sectionHeader = self.createSectionHeader()
//        section.boundarySupplementaryItems = [sectionHeader]
        
        return section
    }
}

extension AppViewController: UICollectionViewDelegate {
    
}

extension AppViewController: UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return items.count
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return items[section].items.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        switch items[indexPath.section].type {
        case .LargeItem:
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "AppLargeItemCollectionViewCell", for: indexPath) as? AppLargeItemCollectionViewCell else {
                return UICollectionViewCell()
            }
            guard let item = items[indexPath.section].items[indexPath.row] as? AppLargeItem else {
                return UICollectionViewCell()
            }
            cell.setup(item: item)
            return cell
            
        case .MediumItem:
            return UICollectionViewCell()
            
        case .SmallItem:
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "AppSmallItemsCollectionViewCell", for: indexPath) as? AppSmallItemsCollectionViewCell else {
                return UICollectionViewCell()
            }
            return cell
        }
    }
}
