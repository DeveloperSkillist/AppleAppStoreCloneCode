//
//  TodayCollectionViewController.swift
//  AppleAppStore
//
//  Created by skillist on 2021/12/01.
//

import UIKit

class TodayCollectionViewController: UICollectionViewController {

    let todayListItemSectionBackground = "TodayListItemSectionBackground"
    
    private lazy var statusBar: UIView = {
        var view = UIView()
        view.backgroundColor = .clear
        view.alpha = 0.9
        return view
    }()
    
    let margin: CGFloat = 16
    var items: [TodayCell] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupCollectionView()
        setupLayout()
        setList()
    }
}

extension TodayCollectionViewController {
    private func setupCollectionView() {
        collectionView.backgroundColor = .systemBackground
        collectionView.delegate = self
        
        collectionView.register(TodayAccountCollectionViewCell.self, forCellWithReuseIdentifier: "TodayAccountCollectionViewCell")
        collectionView.register(TodayLargeItemInfoCollectionViewCell.self, forCellWithReuseIdentifier: "TodayLargeItemInfoCollectionViewCell")
        collectionView.register(TodayListItemsCollectionViewCell.self, forCellWithReuseIdentifier: "TodayListItemsCollectionViewCell")
        
        collectionView.register(TodayListItemsCollectionHeaderView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: "TodayListItemsCollectionHeaderView")
        collectionView.collectionViewLayout = layout()
        collectionView.collectionViewLayout.register(TodayListItemsBackgroundView.self, forDecorationViewOfKind: todayListItemSectionBackground)
    }
    
    private func setupLayout() {
        view.backgroundColor = .black
        
        view.addSubview(statusBar)
        statusBar.snp.makeConstraints {
            $0.top.leading.trailing.equalToSuperview()
            $0.bottom.equalTo(view.safeAreaLayoutGuide.snp.top)
        }
    }
    
    private func setList() {
        items = [
            TodayCell(type: .AccountProfile, items: ["ASD"]),
            
            TodayCell(type: .LargeItemInfo, items: [
                LargeItem(
                    subText: "함께하는 프로젝트!",
                    mainText: "Skillist의\n속업오버로드~",
                    bottomText: "우리 같이 공부해요.",
                    subTitleColor: .darkGray,
                    bottomTitlecolor: .darkGray,
                    imageURL: nil,
                    image: UIImage(named: "orange_skillist")
                )
            ]),
            
            TodayCell(type: .ListItems, items: [
                ListItem(mainText: "대피소 지도", subText: "주변의 대피소 위치를 확인하세요.", isInAppPurchase: true, isInstalled: false, imageURL: nil, image: UIImage(named: "black_skillist")),
                ListItem(mainText: "GestureBar", subText: "Android에서 gesture를 사용하세요.", isInAppPurchase: true, isInstalled: false, imageURL: nil, image: UIImage(named: "orange_skillist")),
                ListItem(mainText: "검정 skillist", subText: "은근 빡세네요.", isInAppPurchase: true, isInstalled: false, imageURL: nil, image: UIImage(named: "black_skillist")),
                ListItem(mainText: "주황 skillist", subText: "은근 힘들어요.", isInAppPurchase: true, isInstalled: false, imageURL: nil, image: UIImage(named: "orange_skillist"))
            ], subText: "Skillist의 앱 목록이에요.", mainText: "대박 대박 앱"),
            
            TodayCell(type: .LargeItemInfo, items: [
                LargeItem(
                    subText: "이렇게 하세요.",
                    mainText: "클론코딩으로 실력을 키우자.",
                    bottomText: "아주 좋은 방법!",
                    subTitleColor: .darkGray,
                    mainTitleColor: .white,
                    bottomTitlecolor: .darkGray,
                    imageURL: nil,
                    image: UIImage(named: "black_skillist")
                )
            ])
        ]
    }
}

extension TodayCollectionViewController {
    private func layout() -> UICollectionViewLayout {
        return UICollectionViewCompositionalLayout { [weak self] section, _ -> NSCollectionLayoutSection? in
            switch self?.items[section].type {
            case .AccountProfile:
                return self?.createAccountSection()
            case .LargeItemInfo:
                return self?.createLargeItemInfoSection()
            case .ListItems:
                return self?.createListItemInfoSection()
            default:
                return nil
            }
        }
    }
    
    private func createAccountSection() -> NSCollectionLayoutSection {
        //아이템
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(1))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        
        //그룹
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .absolute(96))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitem: item, count: 1)
        
        //섹션
        let section = NSCollectionLayoutSection(group: group)
        section.orthogonalScrollingBehavior = .none
        
        return section
    }
    
    private func createLargeItemInfoSection() -> NSCollectionLayoutSection {
        //아이템
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(1))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        
        //그룹
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalWidth(1.4))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitem: item, count: 1)
        
        //섹션
        let section = NSCollectionLayoutSection(group: group)
        section.orthogonalScrollingBehavior = .none
        section.contentInsets = .init(top: margin, leading: margin, bottom: margin, trailing: margin)
        
        return section
    }
    
    private func createListItemInfoSection() -> NSCollectionLayoutSection {
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
        
        let sectionHeader = self.createSectionHeader()
        section.boundarySupplementaryItems = [sectionHeader]
        
        let sectionBackground = NSCollectionLayoutDecorationItem.background(
            elementKind: todayListItemSectionBackground)
        section.decorationItems = [sectionBackground]
        
        return section
    }
    
    private func createSectionHeader() -> NSCollectionLayoutBoundarySupplementaryItem {
        //section header 사이즈
        let layoutSectionHeaderSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .estimated(40))
        
        //section header Layout
        let sectionHeader = NSCollectionLayoutBoundarySupplementaryItem(layoutSize: layoutSectionHeaderSize, elementKind: UICollectionView.elementKindSectionHeader, alignment: .top)
        
        return sectionHeader
     }
}

extension TodayCollectionViewController {
    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return items.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return items[section].items.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        switch items[indexPath.section].type {
        case .AccountProfile:
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "TodayAccountCollectionViewCell", for: indexPath) as? TodayAccountCollectionViewCell else {
                return UICollectionViewCell()
            }
            return cell
            
        case .LargeItemInfo:
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "TodayLargeItemInfoCollectionViewCell", for: indexPath) as? TodayLargeItemInfoCollectionViewCell else {
                return UICollectionViewCell()
            }
            
            guard let largeItem = items[indexPath.section].items[indexPath.row] as? LargeItem else {
                return UICollectionViewCell()
            }
            cell.setup(largeItem: largeItem)
            return cell
            
        case .ListItems:
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "TodayListItemsCollectionViewCell", for: indexPath) as? TodayListItemsCollectionViewCell else {
                return UICollectionViewCell()
            }
            
            guard let listItem = items[indexPath.section].items[indexPath.row] as? ListItem else {
                return UICollectionViewCell()
            }
            cell.setup(item: listItem)
            return cell
        }
    }
    
    override func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        if kind == UICollectionView.elementKindSectionHeader {
            guard let headerView = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: "TodayListItemsCollectionHeaderView", for: indexPath) as? TodayListItemsCollectionHeaderView else {
                return UICollectionReusableView()
            }
            let item = items[indexPath.section]
            headerView.setup(mainText: item.mainText, subText: item.subText)
            return headerView
        }
        return UICollectionReusableView()
    }
    
    override func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let isStatusBarHidden = scrollView.contentOffset.y < 0
        
        if isStatusBarHidden {
            statusBar.backgroundColor = .clear
        } else {
            statusBar.backgroundColor = .systemBackground
        }
        
        statusBar.isHidden = isStatusBarHidden
    }
}
