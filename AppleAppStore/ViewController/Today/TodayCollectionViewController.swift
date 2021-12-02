//
//  TodayCollectionViewController.swift
//  AppleAppStore
//
//  Created by skillist on 2021/12/01.
//

import UIKit

class TodayCollectionViewController: UICollectionViewController {

    let background = "background-element-kind"
    
    private lazy var statusBar: UIView = {
        var view = UIView()
        view.backgroundColor = .clear
        view.alpha = 0.9
        return view
    }()
    
    let margin: CGFloat = 16
    var items: [TodayCell] = [
        TodayCell(type: .AccountProfile, items: ["ASD"]),
        TodayCell(type: .ListItems, items: [
          ListItem(mainText: "테스트용\ndsf", subText: "아 힘들다", isInAppPurchase: true, isInstalled: false, imageURL: nil, image: nil),
          ListItem(mainText: "테스트용", subText: "아 힘들다", isInAppPurchase: true, isInstalled: false, imageURL: nil, image: nil),
          ListItem(mainText: "테스트용", subText: "아 힘들다", isInAppPurchase: true, isInstalled: false, imageURL: nil, image: nil),
          ListItem(mainText: "테스트용", subText: "아 힘들다", isInAppPurchase: true, isInstalled: false, imageURL: nil, image: nil)
        ]),
        TodayCell(type: .LargeItemInfo, items: [
            LargeItem(
                subText: "이렇게 하세요",
                mainText: "구직도 전략이다",
                bottomText: "전문가에게 듣는 이력서 작성 꿀팁.",
                subTitleColor: .darkGray,
                bottomTitlecolor: .darkGray,
                imageURL: nil,
                image: nil
            )
        ]),
        TodayCell(type: .LargeItemInfo, items: [
            LargeItem(
                subText: "이렇게 하세요",
                mainText: "구직도 전략이다",
                bottomText: "전문가에게 듣는 이력서 작성 꿀팁.",
                subTitleColor: .darkGray,
                bottomTitlecolor: .darkGray,
                imageURL: nil,
                image: nil
            )
        ])
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupCollectionView()
        setupLayout()
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
}

extension TodayCollectionViewController {
    private func setupCollectionView() {
        collectionView.backgroundColor = .black
        collectionView.delegate = self
        
        collectionView.register(TodayAccountCollectionViewCell.self, forCellWithReuseIdentifier: "TodayAccountCollectionViewCell")
        collectionView.register(TodayLargeItemInfoCollectionViewCell.self, forCellWithReuseIdentifier: "TodayLargeItemInfoCollectionViewCell")
        collectionView.register(TodayListItemsCollectionViewCell.self, forCellWithReuseIdentifier: "TodayListItemsCollectionViewCell")
        
        collectionView.register(TodayListItemsCollectionHeaderView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: "TodayListItemsCollectionHeaderView")
        collectionView.collectionViewLayout = layout()
        collectionView.collectionViewLayout.register(TodayListItemsBackgroundView.self, forDecorationViewOfKind: background)
    }
    
    private func setupLayout() {
        view.backgroundColor = .black
        
        view.addSubview(statusBar)
        statusBar.snp.makeConstraints {
            $0.top.leading.trailing.equalToSuperview()
            $0.bottom.equalTo(view.safeAreaLayoutGuide.snp.top)
        }
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
            elementKind: background)
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
            //TODO
            headerView.setup(mainText: "구직도 전략이다", subText: "이렇게 하세요")
            return headerView
        }
        return UICollectionReusableView()
    }
    
    override func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let isStatusBarHidden = scrollView.contentOffset.y < 0
        
        if isStatusBarHidden {
            statusBar.backgroundColor = .clear
        } else {
            statusBar.backgroundColor = .darkGray
        }
        
        statusBar.isHidden = isStatusBarHidden
    }
}
