//
//  AppViewController.swift
//  AppleAppStore
//
//  Created by skillist on 2021/12/02.
//

import UIKit
import SnapKit

class AppViewController: UIViewController {
    
    private var sections: [AppItem] = []
    
    private lazy var collectionView: UICollectionView = {
        var collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.delegate = self
        collectionView.dataSource = self
        
        //cell
        collectionView.register(AppLargeItemCollectionViewCell.self, forCellWithReuseIdentifier: "AppLargeItemCollectionViewCell")
        collectionView.register(AppSmallItemsCollectionViewCell.self, forCellWithReuseIdentifier: "AppSmallItemsCollectionViewCell")
        
        //header
        collectionView.register(AppSmallItemCollectionHeaderView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: "AppSmallItemCollectionHeaderView")
        return collectionView
    }()
    
    private lazy var layout: UICollectionViewLayout = {
        return UICollectionViewCompositionalLayout { [weak self] section, _ -> NSCollectionLayoutSection? in
            guard let sectionType = self?.sections[section].type else {
                return nil
            }
            
            switch sectionType {
            case .largeItem:
                return self?.createLargeItemSection()
                
//            case .mediumItem:
//                return self?.createMediumItemInfoSection()
//                return nil
                
            case .smallItem:
                return self?.createSmallItemSection()
            }
        }
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupLayout()
        setupData()
    }
    
    private func setupLayout() {
        view.backgroundColor = .systemBackground
        [
            collectionView
        ].forEach {
            view.addSubview($0)
        }
        
        collectionView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setupNavigationBar()
    }
    
    private func setupNavigationBar() {
        navigationItem.title = "app_title".localized
        navigationController?.navigationBar.prefersLargeTitles = true
        //large title text ??????
        navigationController?.navigationBar.largeTitleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.label]

        //TODO: large title??? accound ??????
//        let accountProfileView = AccountProfileView() navigationController?.navigationBar.addSubview(accountProfileView)
//        accountProfileView.snp.makeConstraints {
//            $0.trailing.equalToSuperview().inset(16)
//            $0.bottom.equalToSuperview().inset(10)
//            $0.width.height.equalTo(30)
//        }
    }
}

extension AppViewController {
    private func createLargeItemSection() -> NSCollectionLayoutSection {
        let sectionMargin: CGFloat = 10
        let groupMargin: CGFloat = 6
        
        //item
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(1))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
//        item.contentInsets = .init(top: 0, leading: 0, bottom: 0, trailing: 0)
        
        //group
        let groupSize = NSCollectionLayoutSize(
            widthDimension: .absolute(view.frame.width - (sectionMargin * 2)),
            heightDimension: .estimated(350)
        )
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitem: item, count: 1)
        group.contentInsets = .init(top: 0, leading: groupMargin, bottom: 0, trailing: groupMargin)
        
        //section
        let section = NSCollectionLayoutSection(group: group)
        section.orthogonalScrollingBehavior = .groupPaging
        section.contentInsets = .init(top: sectionMargin + groupMargin, leading: sectionMargin, bottom: sectionMargin + groupMargin, trailing: sectionMargin)
        
        return section
    }
    
    private func createSmallItemSection() -> NSCollectionLayoutSection {
        //item
        let itemMargin: CGFloat = 4
        let sectionMargin: CGFloat = 12
        
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(1))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        item.contentInsets = .init(top: 0, leading: itemMargin, bottom: 0, trailing: itemMargin)
        
        //group
        let groupSize = NSCollectionLayoutSize(widthDimension: .absolute(view.frame.width - (sectionMargin * 2)), heightDimension: .estimated(250))
        let group = NSCollectionLayoutGroup.vertical(layoutSize: groupSize, subitem: item, count: 3)
//        group.contentInsets = .init(top: 0, leading: 0, bottom: 0, trailing: 0)
        
        //section
        let section = NSCollectionLayoutSection(group: group)
        section.orthogonalScrollingBehavior = .groupPaging
        section.contentInsets = .init(top: sectionMargin + itemMargin, leading: sectionMargin, bottom: sectionMargin + itemMargin, trailing: sectionMargin)
        
        //header
        let sectionHeader = self.createSmallItemSectionHeader()
        section.boundarySupplementaryItems = [sectionHeader]
        
        return section
    }
    
    private func createSmallItemSectionHeader() -> NSCollectionLayoutBoundarySupplementaryItem {
        //section header ?????????
        let layoutSectionHeaderSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .estimated(40))
        
        //section header Layout
        let sectionHeader = NSCollectionLayoutBoundarySupplementaryItem(layoutSize: layoutSectionHeaderSize, elementKind: UICollectionView.elementKindSectionHeader, alignment: .top)
        
        return sectionHeader
     }
}

extension AppViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let detailVC = DetailViewController()
        //TODO detailVC item ??????
        navigationController?.pushViewController(detailVC, animated: true)
    }
}

extension AppViewController: UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return sections.count
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        let section = sections[section]
        return section.items.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let sectionType = sections[indexPath.section].type
        switch sectionType {
        case .largeItem:
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "AppLargeItemCollectionViewCell", for: indexPath) as? AppLargeItemCollectionViewCell else {
                return UICollectionViewCell()
            }
            guard let item = sections[indexPath.section].items[indexPath.row] as? AppLargeItem else {
                return UICollectionViewCell()
            }
            cell.setup(item: item)
            return cell
            
//        case .mediumItem:
//            return UICollectionViewCell()
            
        case .smallItem:
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "AppSmallItemsCollectionViewCell", for: indexPath) as? AppSmallItemsCollectionViewCell else {
                return UICollectionViewCell()
            }
            guard let item = sections[indexPath.section].items[indexPath.row] as? AppSmallItem else {
                return UICollectionViewCell()
            }
            cell.setup(item: item)
            return cell
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        if kind == UICollectionView.elementKindSectionHeader {
            guard let headerView = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: "AppSmallItemCollectionHeaderView", for: indexPath) as? AppSmallItemCollectionHeaderView else {
                return UICollectionReusableView()
            }
            let item = sections[indexPath.section]
            headerView.setup(mainText: item.mainText)
            return headerView
        }
        return UICollectionReusableView()
    }
}

extension AppViewController {
    private func setupData() {
        sections = [
            AppItem(
                type: .largeItem,
                items: [
                    AppLargeItem(
                        subText: "2021 App Store Awards",
                        mainText: "Skillist Project",
                        mainInfoText: "?????? Skillist???",
                        subTextColor: .link,
                        mainTextColor: .label,
                        mainInfoTextColor: .label,
                        imageURL: nil,
                        image: RandomData.image
                    ),
                    AppLargeItem(
                        subText: "2021 App Store Awards",
                        mainText: "Skillist Project",
                        mainInfoText: "?????? ????????????",
                        subTextColor: .link,
                        mainTextColor: .label,
                        mainInfoTextColor: .label,
                        imageURL: nil,
                        image: RandomData.image
                    ),
                    AppLargeItem(
                        subText: "2021 App Store Awards",
                        mainText: "Skillist Project",
                        mainInfoText: "????????? ??????????????????",
                        subTextColor: .link,
                        mainTextColor: .label,
                        mainInfoTextColor: .label,
                        imageURL: nil,
                        image: RandomData.image
                    )
                ],
                subText: "",
                mainText: "",
                mainInfoText: ""
            ),
            AppItem(
                type: .smallItem,
                items: [
                    AppSmallItem(
                        mainText: "?????? skillist",
                        subText: "?????? ??? ?????????",
                        isInAppPurchase: RandomData.boolean,
                        isInstalled: RandomData.boolean,
                        imageURL: nil,
                        image: RandomData.image
                    ),
                    AppSmallItem(
                        mainText: "?????? skillist",
                        subText: "?????? 08?????? ?????????",
                        isInAppPurchase: RandomData.boolean,
                        isInstalled: RandomData.boolean,
                        imageURL: nil,
                        image: RandomData.image
                    ),
                    AppSmallItem(
                        mainText: "?????? skillist",
                        subText: "???~!",
                        isInAppPurchase: RandomData.boolean,
                        isInstalled: RandomData.boolean,
                        imageURL: nil,
                        image: RandomData.image
                    ),
                    AppSmallItem(
                        mainText: "?????? skillist",
                        subText: "????????? ??????",
                        isInAppPurchase: RandomData.boolean,
                        isInstalled: RandomData.boolean,
                        imageURL: nil,
                        image: RandomData.image
                    ),
                    AppSmallItem(
                        mainText: "?????? skillist",
                        subText: "?????? ??? ????????????",
                        isInAppPurchase: RandomData.boolean,
                        isInstalled: RandomData.boolean,
                        imageURL: nil,
                        image: RandomData.image
                    ),
                    AppSmallItem(
                        mainText: "?????? skillist",
                        subText: "?????? ???????????? ?????? ??????",
                        isInAppPurchase: RandomData.boolean,
                        isInstalled: RandomData.boolean,
                        imageURL: nil,
                        image: RandomData.image
                    )
                ],
                mainText: "08 ?????????",
                isAllShowButton: RandomData.boolean
            ),
            AppItem(
                type: .smallItem,
                items: [
                    AppSmallItem(
                        mainText: "?????? skillist",
                        subText: "??? ????????? ??? ?????? ??????",
                        isInAppPurchase: RandomData.boolean,
                        isInstalled: RandomData.boolean,
                        imageURL: nil,
                        image: RandomData.image
                    ),
                    AppSmallItem(
                        mainText: "?????? skillist",
                        subText: "??? ?????? ????????? ?????? ??????",
                        isInAppPurchase: RandomData.boolean,
                        isInstalled: RandomData.boolean,
                        imageURL: nil,
                        image: RandomData.image
                    ),
                    AppSmallItem(
                        mainText: "?????? skillist",
                        subText: "???????????? ?????????",
                        isInAppPurchase: RandomData.boolean,
                        isInstalled: RandomData.boolean,
                        imageURL: nil,
                        image: RandomData.image
                    ),
                    AppSmallItem(
                        mainText: "?????? skillist",
                        subText: "????????? ?????? ??????",
                        isInAppPurchase: RandomData.boolean,
                        isInstalled: RandomData.boolean,
                        imageURL: nil,
                        image: RandomData.image
                    ),
                    AppSmallItem(
                        mainText: "?????? skillist",
                        subText: "???????????? ?????? ?????????",
                        isInAppPurchase: RandomData.boolean,
                        isInstalled: RandomData.boolean,
                        imageURL: nil,
                        image: RandomData.image
                    ),
                    AppSmallItem(
                        mainText: "?????? skillist",
                        subText: "?????? ???????????? ????????? ??????",
                        isInAppPurchase: RandomData.boolean,
                        isInstalled: RandomData.boolean,
                        imageURL: nil,
                        image: RandomData.image
                    ),
                    AppSmallItem(
                        mainText: "?????? skillist",
                        subText: "?????????????????? ?????????",
                        isInAppPurchase: RandomData.boolean,
                        isInstalled: RandomData.boolean,
                        imageURL: nil,
                        image: RandomData.image
                    ),
                    AppSmallItem(
                        mainText: "?????? skillist",
                        subText: "????????? ?????? ?????? ?????? ",
                        isInAppPurchase: RandomData.boolean,
                        isInstalled: RandomData.boolean,
                        imageURL: nil,
                        image: RandomData.image
                    ),
                    AppSmallItem(
                        mainText: "?????? skillist",
                        subText: "?????????",
                        isInAppPurchase: RandomData.boolean,
                        isInstalled: RandomData.boolean,
                        imageURL: nil,
                        image: RandomData.image
                    )
                ],
                mainText: "????????? ??????",
                isAllShowButton: RandomData.boolean
            ),
            AppItem(
                type: .largeItem,
                items: [
                    AppLargeItem(
                        subText: "?????? ?????? ????????? - ?????????",
                        mainText: "2007?????? ????????????",
                        mainInfoText: "????????? ????????? ??? ?????????",
                        subTextColor: .link,
                        mainTextColor: .label,
                        mainInfoTextColor: .label,
                        imageURL: nil,
                        image: RandomData.image
                    ),
                    AppLargeItem(
                        subText: "?????? ?????? ????????? - ??????",
                        mainText: "?????? ???????????? ????????????",
                        mainInfoText: "?????? ?????? ?????? ?????? ???????????????",
                        subTextColor: .link,
                        mainTextColor: .label,
                        mainInfoTextColor: .label,
                        imageURL: nil,
                        image: RandomData.image
                    ),
                    AppLargeItem(
                        subText: "?????? ?????? ????????? - ??????",
                        mainText: "???????????? ?????? ?????? ????????????",
                        mainInfoText: "????????? ????????? ????????? ?????? ??????",
                        subTextColor: .link,
                        mainTextColor: .label,
                        mainInfoTextColor: .label,
                        imageURL: nil,
                        image: RandomData.image
                    )
                ],
                subText: "",
                mainText: "",
                mainInfoText: ""
            )
        ]
    }
}
