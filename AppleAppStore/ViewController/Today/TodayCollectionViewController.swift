//
//  TodayCollectionViewController.swift
//  AppleAppStore
//
//  Created by skillist on 2021/12/01.
//

import UIKit

class TodayCollectionViewController: UICollectionViewController {

    let todaySmallItemSectionBackground = "TodaySmallItemSectionBackground"
    
    private lazy var statusBar: UIView = {
        var view = UIView()
        view.backgroundColor = .clear
        view.alpha = 0.9
        return view
    }()
    
    let margin: CGFloat = 16
    var items: [TodayItem] = []
    
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
//        collectionView.delegate = self
        
        collectionView.register(TodayAccountCollectionViewCell.self, forCellWithReuseIdentifier: "TodayAccountCollectionViewCell")
        collectionView.register(TodayLargeItemCollectionViewCell.self, forCellWithReuseIdentifier: "TodayLargeItemCollectionViewCell")
        collectionView.register(TodaySmallItemCollectionViewCell.self, forCellWithReuseIdentifier: "TodaySmallItemCollectionViewCell")
        
        collectionView.register(TodaySmallItemCollectionHeaderView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: "TodaySmallItemCollectionViewCell")
        collectionView.collectionViewLayout = layout()
        collectionView.collectionViewLayout.register(TodaySmallItemBackgroundView.self, forDecorationViewOfKind: todaySmallItemSectionBackground)
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
            TodayItem(type: .AccountProfile, items: ["myAccount"]),
            
            TodayItem(type: .LargeItem, items: [
                TodayLargeItem(
                    subText: "함께하는 프로젝트!",
                    mainText: "Skillist의\n속업오버로드~",
                    bottomText: "우리 같이 공부해요.",
                    subTitleColor: .darkGray,
                    bottomTitlecolor: .darkGray,
                    imageURL: nil,
                    image: UIImage(named: "orange_skillist")
                )
            ]),
            
            TodayItem(type: .SmallItem, items: [
                TodaySmallItem(mainText: "검정 skillist", subText: "생각보다 빡세네요.", isInAppPurchase: true, isInstalled: false, imageURL: nil, image: UIImage(named: "black_skillist")),
                TodaySmallItem(mainText: "핑크 skillist", subText: "코딩량이 많아요", isInAppPurchase: true, isInstalled: false, imageURL: nil, image: UIImage(named: "pink_skillist")),
                TodaySmallItem(mainText: "블루 skillist", subText: "그래도 재밌어요.", isInAppPurchase: true, isInstalled: false, imageURL: nil, image: UIImage(named: "blue_skillist")),
                TodaySmallItem(mainText: "그레이 skillist", subText: "완전 재밌어요.", isInAppPurchase: true, isInstalled: false, imageURL: nil, image: UIImage(named: "orange_skillist"))
            ], subText: "Skillist의 앱 목록이에요.", mainText: "대박 대박 앱"),
            
            TodayItem(type: .LargeItem, items: [
                TodayLargeItem(
                    subText: "이렇게 하세요.",
                    mainText: "클론코딩으로 실력을 키우자.",
                    bottomText: "아주 좋은 방법!",
                    subTitleColor: .white,
                    mainTitleColor: .white,
                    bottomTitlecolor: .white,
                    imageURL: nil,
                    image: UIImage(named: "purple_skillist")
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
            case .LargeItem:
                return self?.createLargeItemSection()
            case .SmallItem:
                return self?.createSmallItemSection()
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
    
    private func createLargeItemSection() -> NSCollectionLayoutSection {
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
        
        let sectionHeader = self.createSectionHeader()
        section.boundarySupplementaryItems = [sectionHeader]
        
        let sectionBackground = NSCollectionLayoutDecorationItem.background(
            elementKind: todaySmallItemSectionBackground)
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
            
        case .LargeItem:
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "TodayLargeItemCollectionViewCell", for: indexPath) as? TodayLargeItemCollectionViewCell else {
                return UICollectionViewCell()
            }
            
            guard let largeItem = items[indexPath.section].items[indexPath.row] as? TodayLargeItem else {
                return UICollectionViewCell()
            }
            cell.setup(largeItem: largeItem)
            return cell
            
        case .SmallItem:
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "TodaySmallItemCollectionViewCell", for: indexPath) as? TodaySmallItemCollectionViewCell else {
                return UICollectionViewCell()
            }
            
            guard let smallItem = items[indexPath.section].items[indexPath.row] as? TodaySmallItem else {
                return UICollectionViewCell()
            }
            cell.setup(item: smallItem)
            return cell
        }
    }
    
    override func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        if kind == UICollectionView.elementKindSectionHeader {
            guard let headerView = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: "TodaySmallItemCollectionViewCell", for: indexPath) as? TodaySmallItemCollectionHeaderView else {
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
