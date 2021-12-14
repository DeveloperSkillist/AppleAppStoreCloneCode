//
//  TodayCollectionViewController.swift
//  AppleAppStore
//
//  Created by skillist on 2021/12/01.
//

import UIKit

class TodayCollectionViewController: UICollectionViewController {

    private lazy var statusBarView: UIView = {
        var view = UIView()
        view.backgroundColor = .clear
        view.alpha = 0.9
        return view
    }()
    
    let todaySmallItemSectionBackground = "TodaySmallItemSectionBackground"
    let sectionDefaultMargin: CGFloat = 16
    var items: [TodayItem] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupCollectionView()
        setupLayout()
        setData()
    }
}

extension TodayCollectionViewController {
    private func setupCollectionView() {
        collectionView.backgroundColor = .systemBackground

        collectionView.collectionViewLayout = layout()
        
        //cell
        collectionView.register(TodayAccountCollectionViewCell.self, forCellWithReuseIdentifier: "TodayAccountCollectionViewCell")
        collectionView.register(TodayLargeItemCollectionViewCell.self, forCellWithReuseIdentifier: "TodayLargeItemCollectionViewCell")
        collectionView.register(TodaySmallItemCollectionViewCell.self, forCellWithReuseIdentifier: "TodaySmallItemCollectionViewCell")
        
        //header
        collectionView.register(TodaySmallItemCollectionHeaderView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: "TodaySmallItemCollectionViewCell")
        
        //section background
        collectionView.collectionViewLayout.register(TodaySmallItemBackgroundView.self, forDecorationViewOfKind: todaySmallItemSectionBackground)
    }
    
    private func setupLayout() {
        view.backgroundColor = .black
        
        //status bar view
        view.addSubview(statusBarView)
        statusBarView.snp.makeConstraints {
            $0.top.leading.trailing.equalToSuperview()
            $0.bottom.equalTo(view.safeAreaLayoutGuide.snp.top)
        }
    }
}

extension TodayCollectionViewController {
    private func layout() -> UICollectionViewLayout {
        return UICollectionViewCompositionalLayout { [weak self] section, _ -> NSCollectionLayoutSection? in
            let itemType = self?.items[section].type
            switch itemType {
            case .accountProfile:
                return self?.createAccountSection()
                
            case .largeItem:
                return self?.createLargeItemSection()
                
            case .smallItem:
                return self?.createSmallItemSection()
                
            default:
                return nil
            }
        }
    }
    
    private func createAccountSection() -> NSCollectionLayoutSection {
        //item
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(1))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        
        //group
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .absolute(96))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitem: item, count: 1)
        
        //section
        let section = NSCollectionLayoutSection(group: group)
        section.orthogonalScrollingBehavior = .none
        section.contentInsets = .init(top: 0, leading: sectionDefaultMargin, bottom: 0, trailing: sectionDefaultMargin)
        
        return section
    }
    
    private func createLargeItemSection() -> NSCollectionLayoutSection {
        //item
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(1))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        
        //group
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalWidth(1.4))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitem: item, count: 1)
        
        //section
        let section = NSCollectionLayoutSection(group: group)
        section.orthogonalScrollingBehavior = .none
        section.contentInsets = .init(top: sectionDefaultMargin, leading: sectionDefaultMargin, bottom: sectionDefaultMargin, trailing: sectionDefaultMargin)
        
        return section
    }
    
    private func createSmallItemSection() -> NSCollectionLayoutSection {
        //item
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(1))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        
        //group
        let groupSize = NSCollectionLayoutSize(widthDimension: .absolute(collectionView.frame.size.width - 32), heightDimension: .estimated(310))
        let group = NSCollectionLayoutGroup.vertical(layoutSize: groupSize, subitem: item, count: 4)
        
        //section
        let section = NSCollectionLayoutSection(group: group)
        section.orthogonalScrollingBehavior = .none
        section.contentInsets = .init(top: sectionDefaultMargin, leading: sectionDefaultMargin, bottom: sectionDefaultMargin + 30, trailing: sectionDefaultMargin)
        
        let sectionHeader = self.createSamllItemSectionHeader()
        section.boundarySupplementaryItems = [sectionHeader]
        
        let sectionBackground = NSCollectionLayoutDecorationItem.background(
            elementKind: todaySmallItemSectionBackground)
        section.decorationItems = [sectionBackground]
        
        return section
    }
    
    private func createSamllItemSectionHeader() -> NSCollectionLayoutBoundarySupplementaryItem {
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
        let itemType = items[indexPath.section].type
        switch itemType {
        case .accountProfile:
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "TodayAccountCollectionViewCell", for: indexPath) as? TodayAccountCollectionViewCell else {
                return UICollectionViewCell()
            }
            return cell
            
        case .largeItem:
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "TodayLargeItemCollectionViewCell", for: indexPath) as? TodayLargeItemCollectionViewCell else {
                return UICollectionViewCell()
            }
            guard let largeItem = items[indexPath.section].items[indexPath.row] as? TodayLargeItem else {
                return UICollectionViewCell()
            }
            cell.setup(largeItem: largeItem)
            return cell
            
        case .smallItem:
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
            statusBarView.backgroundColor = .clear
        } else {
            statusBarView.backgroundColor = .systemBackground
        }
        statusBarView.isHidden = isStatusBarHidden
    }
}

extension TodayCollectionViewController {
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        //TODO: 아이템 터치시 화면 이동
//        let item = items[indexPath.section].items[indexPath.row]
//        let detailVC = DetailViewController()
//        detailVC.modalPresentationStyle = .overFullScreen
//        present(detailVC, animated: true, completion: nil)
    }
}

extension TodayCollectionViewController {
    private func setData() {
        items = [
            TodayItem(type: .accountProfile, items: ["myAccount"]),
            
            TodayItem(type: .largeItem, items: [
                TodayLargeItem(
                    subText: "함께하는 프로젝트!",
                    mainText: "Skillist의\n속업오버로드~",
                    bottomText: "우리 같이 공부해요.",
                    subTitleColor: .darkGray,
                    bottomTitlecolor: .darkGray,
                    imageURL: nil,
                    image: RandomData.image
                )
            ]),
            
            TodayItem(type: .smallItem, items: [
                TodaySmallItem(mainText: "랜덤 skillist", subText: "생각보다 빡세네요.", isInAppPurchase: RandomData.boolean, isInstalled: RandomData.boolean, imageURL: nil, image: RandomData.image),
                TodaySmallItem(mainText: "랜덤 skillist", subText: "코딩량이 많아요", isInAppPurchase: RandomData.boolean, isInstalled: RandomData.boolean, imageURL: nil, image: RandomData.image),
                TodaySmallItem(mainText: "랜덤 skillist", subText: "그래도 재밌어요.", isInAppPurchase: RandomData.boolean, isInstalled: RandomData.boolean, imageURL: nil, image: RandomData.image),
                TodaySmallItem(mainText: "랜덤 skillist", subText: "완전 재밌어요.", isInAppPurchase: RandomData.boolean, isInstalled: RandomData.boolean, imageURL: nil, image: RandomData.image)
            ], subText: "Skillist의 앱 목록이에요.", mainText: "대박 대박 앱"),
            
            TodayItem(type: .largeItem, items: [
                TodayLargeItem(
                    subText: "이렇게 하세요.",
                    mainText: "클론코딩으로 실력을 키우자.",
                    bottomText: "아주 좋은 방법!",
                    subTitleColor: .white,
                    mainTitleColor: .white,
                    bottomTitlecolor: .white,
                    imageURL: nil,
                    image: RandomData.image
                )
            ])
        ]
    }
}
