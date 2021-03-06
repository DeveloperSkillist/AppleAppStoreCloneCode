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
    var sections: [TodayItem] = []
    
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
            let itemType = self?.sections[section].type
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
        //section header ?????????
        let layoutSectionHeaderSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .estimated(40))
        
        //section header Layout
        let sectionHeader = NSCollectionLayoutBoundarySupplementaryItem(layoutSize: layoutSectionHeaderSize, elementKind: UICollectionView.elementKindSectionHeader, alignment: .top)
        
        return sectionHeader
     }
}

extension TodayCollectionViewController {
    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return sections.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return sections[section].items.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let itemType = sections[indexPath.section].type
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
            guard let largeItem = sections[indexPath.section].items[indexPath.row] as? TodayLargeItem else {
                return UICollectionViewCell()
            }
            cell.setup(largeItem: largeItem)
            return cell
            
        case .smallItem:
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "TodaySmallItemCollectionViewCell", for: indexPath) as? TodaySmallItemCollectionViewCell else {
                return UICollectionViewCell()
            }
            guard let smallItem = sections[indexPath.section].items[indexPath.row] as? TodaySmallItem else {
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
            let item = sections[indexPath.section]
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
        //TODO: ????????? ????????? ?????? ??????
//        let item = items[indexPath.section].items[indexPath.row]
//        let detailVC = DetailViewController()
//        detailVC.modalPresentationStyle = .overFullScreen
//        present(detailVC, animated: true, completion: nil)
    }
}

extension TodayCollectionViewController {
    private func setData() {
        sections = [
            TodayItem(type: .accountProfile, items: ["myAccount"]),
            
            TodayItem(type: .largeItem, items: [
                TodayLargeItem(
                    subText: "???????????? ????????????!",
                    mainText: "Skillist???\n??????????????????~",
                    bottomText: "?????? ?????? ????????????.",
                    subTitleColor: .darkGray,
                    bottomTitlecolor: .darkGray,
                    imageURL: nil,
                    image: RandomData.image
                )
            ]),
            
            TodayItem(type: .smallItem, items: [
                TodaySmallItem(mainText: "?????? skillist", subText: "???????????? ????????????.", isInAppPurchase: RandomData.boolean, isInstalled: RandomData.boolean, imageURL: nil, image: RandomData.image),
                TodaySmallItem(mainText: "?????? skillist", subText: "???????????? ?????????", isInAppPurchase: RandomData.boolean, isInstalled: RandomData.boolean, imageURL: nil, image: RandomData.image),
                TodaySmallItem(mainText: "?????? skillist", subText: "????????? ????????????.", isInAppPurchase: RandomData.boolean, isInstalled: RandomData.boolean, imageURL: nil, image: RandomData.image),
                TodaySmallItem(mainText: "?????? skillist", subText: "?????? ????????????.", isInAppPurchase: RandomData.boolean, isInstalled: RandomData.boolean, imageURL: nil, image: RandomData.image)
            ], subText: "Skillist??? ??? ???????????????.", mainText: "?????? ?????? ???"),
            
            TodayItem(type: .largeItem, items: [
                TodayLargeItem(
                    subText: "????????? ?????????.",
                    mainText: "?????????????????? ????????? ?????????.",
                    bottomText: "?????? ?????? ??????!",
                    subTitleColor: .white,
                    mainTitleColor: .white,
                    bottomTitlecolor: .white,
                    imageURL: nil,
                    image: RandomData.image
                )
            ]),
            
            TodayItem(type: .largeItem, items: [
                TodayLargeItem(
                    subText: "???????????? ????????????!",
                    mainText: "Skillist???\n??????????????????~",
                    bottomText: "?????? ?????? ????????????.",
                    subTitleColor: .darkGray,
                    bottomTitlecolor: .darkGray,
                    imageURL: nil,
                    image: RandomData.image
                )
            ]),
            
            TodayItem(type: .smallItem, items: [
                TodaySmallItem(mainText: "?????? skillist", subText: "???????????? ????????????.", isInAppPurchase: RandomData.boolean, isInstalled: RandomData.boolean, imageURL: nil, image: RandomData.image),
                TodaySmallItem(mainText: "?????? skillist", subText: "???????????? ?????????", isInAppPurchase: RandomData.boolean, isInstalled: RandomData.boolean, imageURL: nil, image: RandomData.image),
                TodaySmallItem(mainText: "?????? skillist", subText: "????????? ????????????.", isInAppPurchase: RandomData.boolean, isInstalled: RandomData.boolean, imageURL: nil, image: RandomData.image),
                TodaySmallItem(mainText: "?????? skillist", subText: "?????? ????????????.", isInAppPurchase: RandomData.boolean, isInstalled: RandomData.boolean, imageURL: nil, image: RandomData.image)
            ], subText: "Skillist??? ??? ???????????????.", mainText: "?????? ?????? ???"),
            
            TodayItem(type: .largeItem, items: [
                TodayLargeItem(
                    subText: "????????? ?????????.",
                    mainText: "?????????????????? ????????? ?????????.",
                    bottomText: "?????? ?????? ??????!",
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
