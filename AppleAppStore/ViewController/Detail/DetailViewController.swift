//
//  DetailViewController.swift
//  AppleAppStore
//
//  Created by skillist on 2021/12/11.
//

import UIKit

class DetailViewController: UIViewController {
    
    private var items: [DetailItem] = []
    
    private lazy var collectionView: UICollectionView = {
        var collectionView = UICollectionView(
            frame: .zero,
            collectionViewLayout: collectionViewLayout
        )
        collectionView.backgroundColor = .systemBackground
        
        collectionView.dataSource = self
//        collectionView.delegate = self
        
        //cell
        collectionView.register(DetailMainCollectionViewCell.self, forCellWithReuseIdentifier: "DetailMainCollectionViewCell")
        collectionView.register(DetailInfoShortItemCollectionViewCell.self, forCellWithReuseIdentifier: "DetailInfoShortItemCollectionViewCell")
        collectionView.register(DetailScreenShotCollectionViewCell.self, forCellWithReuseIdentifier: "DetailScreenShotCollectionViewCell")
        collectionView.register(DetailTextInfoCollectionViewCell.self, forCellWithReuseIdentifier: "DetailTextInfoCollectionViewCell")
        collectionView.register(DetailReviewCollectionViewCell.self, forCellWithReuseIdentifier: "DetailReviewCollectionViewCell")
    
        //header
        collectionView.register(DetailLineHeaderView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: "DetailLineHeaderView")
        collectionView.register(DetailLargeTitleHeaderView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: "DetailLargeTitleHeaderView")
        collectionView.register(DetailReviewHeaderView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: "DetailReviewHeaderView")
        return collectionView
    }()
    
    private lazy var collectionViewLayout: UICollectionViewLayout = {
        return UICollectionViewCompositionalLayout { [weak self] section, _ -> NSCollectionLayoutSection? in
            let itemType = self?.items[section].itemType
            switch itemType {
            case .main:
                return self?.createMainSection()
                
            case .infoShortItem:
                return self?.createInfoShortItemSection()
                
            case .screenShots:
                return self?.createScreenShotItemSection()
                
            case .textInfo:
                return self?.createTextInfoWithHeaderSection()
                
            case .review:
                return self?.createReviewSection()
                
            default:
                return nil
            }
        }
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        setupLayout()
        setDummyData()
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
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setupNavigationBar()
    }
    
    private func setupNavigationBar() {
        navigationController?.navigationBar.prefersLargeTitles = false
    }
}

extension DetailViewController {
    private func createMainSection() -> NSCollectionLayoutSection {
        let itemMargin: CGFloat = 5
        let sectionMargin: CGFloat = 15
        
        //item
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(1))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        item.contentInsets = .init(top: itemMargin, leading: itemMargin, bottom: itemMargin, trailing: itemMargin)
        
        //group
        let groupSize = NSCollectionLayoutSize(widthDimension: .absolute(self.view.frame.width - (sectionMargin * 2)), heightDimension: .absolute(100))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitem: item, count: 1)
//        group.contentInsets = .init(top: 0, leading: 0, bottom: 0, trailing: 0)
        
        //section
        let section = NSCollectionLayoutSection(group: group)
        section.orthogonalScrollingBehavior = .none
        section.contentInsets = .init(top: sectionMargin, leading: sectionMargin, bottom: sectionMargin, trailing: sectionMargin)
        
        return section
    }
    
    private func createInfoShortItemSection() -> NSCollectionLayoutSection {
        let itemMargin: CGFloat = 5
        let sectionMargin: CGFloat = 15
        
        //item
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(1))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        item.contentInsets = .init(top: itemMargin, leading: itemMargin, bottom: itemMargin, trailing: itemMargin)
        
        //group
        let groupSize = NSCollectionLayoutSize(widthDimension: .absolute(100), heightDimension: .absolute(100))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitem: item, count: 1)
//        group.contentInsets = .init(top: 0, leading: 0, bottom: 0, trailing: 0)
        
        //section
        let section = NSCollectionLayoutSection(group: group)
        section.orthogonalScrollingBehavior = .continuous
        section.contentInsets = .init(top: sectionMargin, leading: sectionMargin, bottom: sectionMargin, trailing: sectionMargin)
        
        //header
        let sectionHeader = createHeader()
        section.boundarySupplementaryItems = [sectionHeader]
        
        return section
    }
    
    private func createScreenShotItemSection() -> NSCollectionLayoutSection {
        let itemMargin: CGFloat = 5
        let sectionMargin: CGFloat = 15
        
        //item
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(1))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        item.contentInsets = .init(top: itemMargin, leading: itemMargin, bottom: itemMargin, trailing: itemMargin)
        
        //group
        let groupSize = NSCollectionLayoutSize(widthDimension: .absolute((self.view.frame.width - (sectionMargin * 2)) / 1.5), heightDimension: .absolute(500))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitem: item, count: 1)
//        group.contentInsets = .init(top: 0, leading: 0, bottom: 0, trailing: 0)
        
        //section
        let section = NSCollectionLayoutSection(group: group)
        section.orthogonalScrollingBehavior = .groupPaging
        section.contentInsets = .init(top: sectionMargin, leading: sectionMargin, bottom: sectionMargin, trailing: sectionMargin)
        
        return section
    }
    
    private func createTextInfoWithHeaderSection() -> NSCollectionLayoutSection {
        let itemMargin: CGFloat = 5
        let sectionMargin: CGFloat = 15
        
        //item
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .estimated(1))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        item.contentInsets = .init(top: itemMargin, leading: itemMargin, bottom: itemMargin, trailing: itemMargin)
        
        //group
        let groupSize = NSCollectionLayoutSize(widthDimension: .absolute(self.view.frame.width - (sectionMargin * 2)), heightDimension: .estimated(1))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitem: item, count: 1)
//        group.contentInsets = .init(top: 0, leading: 0, bottom: 0, trailing: 0)
        
        //section
        let section = NSCollectionLayoutSection(group: group)
        section.orthogonalScrollingBehavior = .none
        section.contentInsets = .init(top: sectionMargin, leading: sectionMargin, bottom: sectionMargin, trailing: sectionMargin)
        
        //header
        let sectionHeader = createHeader()
        section.boundarySupplementaryItems = [sectionHeader]
        
        return section
    }
    
    private func createReviewSection() -> NSCollectionLayoutSection {
        let itemMargin: CGFloat = 5
        let sectionMargin: CGFloat = 15
        
        //item
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(1))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        item.contentInsets = .init(top: itemMargin, leading: itemMargin, bottom: itemMargin, trailing: itemMargin)
        
        //group
        let width = (self.view.frame.width - (sectionMargin * 2))
        let groupSize = NSCollectionLayoutSize(widthDimension: .absolute(width), heightDimension: .absolute(width * 0.7))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitem: item, count: 1)
//        group.contentInsets = .init(top: 0, leading: 0, bottom: 0, trailing: 0)
        
        //section
        let section = NSCollectionLayoutSection(group: group)
        section.orthogonalScrollingBehavior = .groupPaging
        section.contentInsets = .init(top: sectionMargin, leading: sectionMargin, bottom: sectionMargin, trailing: sectionMargin)
        
        //header
        let sectionHeader = createHeader()
        section.boundarySupplementaryItems = [sectionHeader]
        
        return section
    }
}

extension DetailViewController {
    private func createHeader() -> NSCollectionLayoutBoundarySupplementaryItem {
        //section에 보여줄 헤더를 구현
        let headerSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1),
            heightDimension: .estimated(1)
        )
        
        let header = NSCollectionLayoutBoundarySupplementaryItem(
            layoutSize: headerSize,
            elementKind: UICollectionView.elementKindSectionHeader,
            alignment: .top
        )
        
        return header
    }
}

extension DetailViewController: UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return items.count
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return items[section].items.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        switch items[indexPath.section].itemType {
            
        case .main:
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "DetailMainCollectionViewCell", for: indexPath) as? DetailMainCollectionViewCell else {
                return UICollectionViewCell()
            }
            return cell
            
        case .infoShortItem:
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "DetailInfoShortItemCollectionViewCell", for: indexPath) as? DetailInfoShortItemCollectionViewCell else {
                return UICollectionViewCell()
            }
            return cell
            
        case .screenShots:
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "DetailScreenShotCollectionViewCell", for: indexPath) as? DetailScreenShotCollectionViewCell else {
                return UICollectionViewCell()
            }
            return cell
            
        case .textInfo:
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "DetailTextInfoCollectionViewCell", for: indexPath) as? DetailTextInfoCollectionViewCell else {
                return UICollectionViewCell()
            }
            cell.collectionViewLayoutUpdateDelegate = self
            return cell
            
        case .review:
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "DetailReviewCollectionViewCell", for: indexPath) as? DetailReviewCollectionViewCell else {
                return UICollectionViewCell()
            }
            return cell
            
        case .newFeatureInfo:
            return UICollectionViewCell()
            
        case .infoListItem:
            return UICollectionViewCell()
        }
    }

    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        switch kind {
        case UICollectionView.elementKindSectionHeader:
            switch items[indexPath.section].headerType {
                
            case .line:
                guard let headerView = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: "DetailLineHeaderView", for: indexPath) as? DetailLineHeaderView else {
                    return UICollectionReusableView()
                }
                return headerView
                
            case .largeTitle:
                guard let headerView = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: "DetailLargeTitleHeaderView", for: indexPath) as? DetailLargeTitleHeaderView else {
                    return UICollectionReusableView()
                }
                headerView.setupLargeTitleData(largeTitleText: "새로운 기능", largeButtonText: "버전 기록")
                return headerView
                
            case .review:
                guard let headerView = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: "DetailReviewHeaderView", for: indexPath) as? DetailReviewHeaderView else {
                    return UICollectionReusableView()
                }
                headerView.setupLargeTitleData(largeTitleText: "평가 및 리뷰", largeButtonText: "모두 보기")
                return headerView
                
            case .none:
                return UICollectionReusableView()
            }
            
        default:
            return UICollectionReusableView()
        }
    }
}

extension DetailViewController: CollectionViewLayoutUpdateDelegate {
    func collectionViewLayoutUpdate() {
        self.collectionView.collectionViewLayout.invalidateLayout()
    }
}

extension DetailViewController {
    private func setDummyData() {
        items.append(
            DetailItem(itemType: .main, items: ["temp"], headerType: .none)
        )
        items.append(
            DetailItem(itemType: .infoShortItem, items: ["temp","12","12","12","12","12"], headerType: .line)
        )
        items.append(
            DetailItem(itemType: .screenShots, items: ["temp","12","12","12","12","12"], headerType: .none)
        )
        items.append(
            DetailItem(itemType: .textInfo, items: ["temp"], headerType: .largeTitle)
        )
        items.append(
            DetailItem(itemType: .textInfo, items: ["temp"], headerType: .largeTitle)
        )
        items.append(
            DetailItem(itemType: .review, items: ["temp","temp","temp","temp","temp","temp"], headerType: .review)
        )
        collectionView.reloadData()
    }
}
