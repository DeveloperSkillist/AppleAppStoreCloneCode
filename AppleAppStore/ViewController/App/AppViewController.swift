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
        //large title text 설정
        navigationController?.navigationBar.largeTitleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.label]

        //TODO: large title에 accound 추가
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
        //section header 사이즈
        let layoutSectionHeaderSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .estimated(40))
        
        //section header Layout
        let sectionHeader = NSCollectionLayoutBoundarySupplementaryItem(layoutSize: layoutSectionHeaderSize, elementKind: UICollectionView.elementKindSectionHeader, alignment: .top)
        
        return sectionHeader
     }
}

extension AppViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let detailVC = DetailViewController()
        //TODO detailVC item 설정
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
                        mainInfoText: "이게 Skillist다",
                        subTextColor: .link,
                        mainTextColor: .label,
                        mainInfoTextColor: .label,
                        imageURL: nil,
                        image: RandomData.image
                    ),
                    AppLargeItem(
                        subText: "2021 App Store Awards",
                        mainText: "Skillist Project",
                        mainInfoText: "이게 스터디다",
                        subTextColor: .link,
                        mainTextColor: .label,
                        mainInfoTextColor: .label,
                        imageURL: nil,
                        image: RandomData.image
                    ),
                    AppLargeItem(
                        subText: "2021 App Store Awards",
                        mainText: "Skillist Project",
                        mainInfoText: "이것이 클론코딩이다",
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
                        mainText: "랜덤 skillist",
                        subText: "지금 내 기분은",
                        isInAppPurchase: RandomData.boolean,
                        isInstalled: RandomData.boolean,
                        imageURL: nil,
                        image: RandomData.image
                    ),
                    AppSmallItem(
                        mainText: "랜덤 skillist",
                        subText: "마치 08년도 베이식",
                        isInAppPurchase: RandomData.boolean,
                        isInstalled: RandomData.boolean,
                        imageURL: nil,
                        image: RandomData.image
                    ),
                    AppSmallItem(
                        mainText: "랜덤 skillist",
                        subText: "워~!",
                        isInAppPurchase: RandomData.boolean,
                        isInstalled: RandomData.boolean,
                        imageURL: nil,
                        image: RandomData.image
                    ),
                    AppSmallItem(
                        mainText: "랜덤 skillist",
                        subText: "데리고 와봐",
                        isInAppPurchase: RandomData.boolean,
                        isInstalled: RandomData.boolean,
                        imageURL: nil,
                        image: RandomData.image
                    ),
                    AppSmallItem(
                        mainText: "랜덤 skillist",
                        subText: "네가 랩 잘한다는",
                        isInAppPurchase: RandomData.boolean,
                        isInstalled: RandomData.boolean,
                        imageURL: nil,
                        image: RandomData.image
                    ),
                    AppSmallItem(
                        mainText: "랜덤 skillist",
                        subText: "나는 조광일의 랩을 따라",
                        isInAppPurchase: RandomData.boolean,
                        isInstalled: RandomData.boolean,
                        imageURL: nil,
                        image: RandomData.image
                    )
                ],
                mainText: "08 베이식",
                isAllShowButton: RandomData.boolean
            ),
            AppItem(
                type: .smallItem,
                items: [
                    AppSmallItem(
                        mainText: "랜덤 skillist",
                        subText: "난 모두가 잘 되길 빌어",
                        isInAppPurchase: RandomData.boolean,
                        isInstalled: RandomData.boolean,
                        imageURL: nil,
                        image: RandomData.image
                    ),
                    AppSmallItem(
                        mainText: "랜덤 skillist",
                        subText: "이 말이 거짓말 같다 해도",
                        isInAppPurchase: RandomData.boolean,
                        isInstalled: RandomData.boolean,
                        imageURL: nil,
                        image: RandomData.image
                    ),
                    AppSmallItem(
                        mainText: "랜덤 skillist",
                        subText: "확실한건 더이상",
                        isInAppPurchase: RandomData.boolean,
                        isInstalled: RandomData.boolean,
                        imageURL: nil,
                        image: RandomData.image
                    ),
                    AppSmallItem(
                        mainText: "랜덤 skillist",
                        subText: "상처를 주기 싫어",
                        isInAppPurchase: RandomData.boolean,
                        isInstalled: RandomData.boolean,
                        imageURL: nil,
                        image: RandomData.image
                    ),
                    AppSmallItem(
                        mainText: "랜덤 skillist",
                        subText: "이제와서 보니 세상이",
                        isInAppPurchase: RandomData.boolean,
                        isInstalled: RandomData.boolean,
                        imageURL: nil,
                        image: RandomData.image
                    ),
                    AppSmallItem(
                        mainText: "랜덤 skillist",
                        subText: "우릴 만들었단 생각이 들어",
                        isInAppPurchase: RandomData.boolean,
                        isInstalled: RandomData.boolean,
                        imageURL: nil,
                        image: RandomData.image
                    ),
                    AppSmallItem(
                        mainText: "랜덤 skillist",
                        subText: "얻은것보다도 잃은게",
                        isInAppPurchase: RandomData.boolean,
                        isInstalled: RandomData.boolean,
                        imageURL: nil,
                        image: RandomData.image
                    ),
                    AppSmallItem(
                        mainText: "랜덤 skillist",
                        subText: "많은것 같어 사실 너도 ",
                        isInAppPurchase: RandomData.boolean,
                        isInstalled: RandomData.boolean,
                        imageURL: nil,
                        image: RandomData.image
                    ),
                    AppSmallItem(
                        mainText: "랜덤 skillist",
                        subText: "알잖아",
                        isInAppPurchase: RandomData.boolean,
                        isInstalled: RandomData.boolean,
                        imageURL: nil,
                        image: RandomData.image
                    )
                ],
                mainText: "내일이 오면",
                isAllShowButton: RandomData.boolean
            ),
            AppItem(
                type: .largeItem,
                items: [
                    AppLargeItem(
                        subText: "너와 나의 메모리 - 베이식",
                        mainText: "2007년의 슈퍼루키",
                        mainInfoText: "국힙의 미래가 내 대명사",
                        subTextColor: .link,
                        mainTextColor: .label,
                        mainInfoTextColor: .label,
                        imageURL: nil,
                        image: RandomData.image
                    ),
                    AppLargeItem(
                        subText: "너와 나의 메모리 - 쿤타",
                        mainText: "좁은 골목길을 들어가면",
                        mainInfoText: "빛이 반만 드는 창에 우리가보여",
                        subTextColor: .link,
                        mainTextColor: .label,
                        mainInfoTextColor: .label,
                        imageURL: nil,
                        image: RandomData.image
                    ),
                    AppLargeItem(
                        subText: "너와 나의 메모리 - 쿤타",
                        mainText: "감옥같은 방에 빛이 들어오면",
                        mainInfoText: "막연한 오늘의 희망이 잠깐 보여",
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
