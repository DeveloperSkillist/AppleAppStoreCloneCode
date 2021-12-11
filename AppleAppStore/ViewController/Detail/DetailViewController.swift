//
//  DetailViewController.swift
//  AppleAppStore
//
//  Created by skillist on 2021/12/11.
//

import UIKit

class DetailViewController: UIViewController {
    
    var items: [DetailItem] = []
    private lazy var collectionView: UICollectionView = {
        var collectionView = UICollectionView(
            frame: .zero,
            collectionViewLayout: collectionViewLayout
        )
        collectionView.dataSource = self
//        collectionView.delegate = self
        
        collectionView.backgroundColor = .systemBackground
        collectionView.register(DetailMainCollectionViewCell.self, forCellWithReuseIdentifier: "DetailMainCollectionViewCell")
        collectionView.register(DetailInfoShortItemCollectionViewCell.self, forCellWithReuseIdentifier: "DetailInfoShortItemCollectionViewCell")
        collectionView.register(DetailScreenShotCollectionViewCell.self, forCellWithReuseIdentifier: "DetailScreenShotCollectionViewCell")
        collectionView.register(DetailLineCollectionHeaderView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: "DetailLineCollectionHeaderView")
        return collectionView
    }()
    
    private lazy var collectionViewLayout: UICollectionViewLayout = {
        return UICollectionViewCompositionalLayout { [weak self] section, _ -> NSCollectionLayoutSection? in
            switch self?.items[section].itemType {
            case .main:
                return self?.createMainSection()
                
            case .infoShortItem:
                return self?.createInfoShortItemSection()
                
            case .screenShots:
                return self?.createScreenShotItemSection()
            default:
                return nil
            }
        }
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        setupNavigationBar()
        setupLayout()
        setDummyData()
    }
    
    private func setupNavigationBar() {
        navigationController?.navigationBar.prefersLargeTitles = false
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
        let sectionHeader = createLineHeader()
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
}

extension DetailViewController {
    private func createLineHeader() -> NSCollectionLayoutBoundarySupplementaryItem {
        //section에 보여줄 헤더를 구현
        let headerSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1),
            heightDimension: .absolute(1)
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
            
        case .infoText:
            return UICollectionViewCell()
            
        case .review:
            return UICollectionViewCell()
            
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
                guard let headerView = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: "DetailLineCollectionHeaderView", for: indexPath) as? DetailLineCollectionHeaderView else {
                    return UICollectionReusableView()
                }
                return headerView
                
            case .none:
                return UICollectionReusableView()
            }
            
        default:
            return UICollectionReusableView()
        }
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
        collectionView.reloadData()
    }
}
