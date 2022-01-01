//
//  DetailViewController.swift
//  AppleAppStore
//
//  Created by skillist on 2021/12/11.
//

import UIKit

class DetailViewController: UIViewController {
    
    private lazy var navigationAppView: UIView = {
        let uiView = UIView()
        uiView.snp.makeConstraints {
            $0.width.equalTo(64)
            $0.height.equalTo(64)
        }
        
        var iconView = DownloadableImageView()
        if let item = item {
            iconView.downloadImage(url: item.artworkUrl512)
        }
        iconView.layer.cornerRadius = 10
        iconView.layer.masksToBounds = true
        iconView.contentMode = .scaleAspectFit

        uiView.addSubview(iconView)
        
        iconView.snp.makeConstraints {
            $0.width.height.equalTo(40)
            $0.center.equalTo(uiView)
        }
        return uiView
    }()
    
    private lazy var navigationButton: UIBarButtonItem = {
        let button = UIButton()
        button.backgroundColor = .link
        button.setTitle("app_download_title".localized, for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.layer.cornerRadius = 15
        button.clipsToBounds = true
        button.snp.makeConstraints {
            $0.width.equalTo(70)
        }
        return UIBarButtonItem(customView: button)
    }()
    
    lazy var isHiddenNavigationBarAppInfo: Bool = false {
        didSet {
            if oldValue == isHiddenNavigationBarAppInfo {
                return
            }
            
            navigationAppView.isHidden = isHiddenNavigationBarAppInfo
            navigationButton.customView?.isHidden = isHiddenNavigationBarAppInfo
        }
    }
    
    var item: SearchItemResult? {
        willSet {
            sections.removeAll()
            
            guard let item = newValue else {
                return
            }
            
            //TODO: section 설정
            sections.append(
                DetailItem(itemType: .main, headerType: .none)
            )
            
            sections.append(
                DetailItem(itemType: .infoShortItem, items: item.languageCodesISO2A, headerType: .line)
            )
            
            sections.append(
                DetailItem(itemType: .screenShots, items: item.screenshotUrls, headerType: .none)
            )
            
            sections.append(
                DetailItem(itemType: .textDescription, headerType: .line)
            )
            
            sections.append(
                DetailItem(itemType: .review, items: item.supportedDevices, headerType: .review)
            )
            
            sections.append(
                DetailItem(itemType: .textInfo, headerType: .largeTitleWithButton)
            )
            
            sections.append(
                DetailItem(
                    itemType: .infoListItem,
                    items: [
                        item.artistName,
                        item.fileSizeBytes,
                        item.languageCodesISO2A.description,
                        item.minimumOSVersion,
                        item.releaseNotes
                    ],
                    itemNames: [
                        "제공자",
                        "크기",
                        "언어",
                        "최소 버전",
                        "배포 노트"
                    ],
                    isExpanded: [
                        false,
                        false,
                        false,
                        false,
                        false
                    ],
                    headerType: .largeTitleWithButton
                )
            )
        }
    }
    private var sections: [DetailItem] = []
    
    private lazy var collectionView: UICollectionView = {
        var collectionView = UICollectionView(
            frame: .zero,
            collectionViewLayout: collectionViewLayout
        )
        collectionView.backgroundColor = .systemBackground
        
        collectionView.dataSource = self
        collectionView.delegate = self
        
        //cell
        collectionView.register(DetailMainCollectionViewCell.self, forCellWithReuseIdentifier: "DetailMainCollectionViewCell")
        collectionView.register(DetailInfoShortItemCollectionViewCell.self, forCellWithReuseIdentifier: "DetailInfoShortItemCollectionViewCell")
        collectionView.register(DetailScreenShotCollectionViewCell.self, forCellWithReuseIdentifier: "DetailScreenShotCollectionViewCell")
        collectionView.register(DetailTextInfoCollectionViewCell.self, forCellWithReuseIdentifier: "DetailTextInfoCollectionViewCell")
        collectionView.register(DetailReviewCollectionViewCell.self, forCellWithReuseIdentifier: "DetailReviewCollectionViewCell")
        collectionView.register(DetailInfoInfoCollectionViewCell.self, forCellWithReuseIdentifier: "DetailInfoInfoCollectionViewCell")
        
        //header
        collectionView.register(DetailLineHeaderView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: "DetailLineHeaderView")
        collectionView.register(DetailLargeTitleWithButtonHeaderView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: "DetailLargeTitleWithButtonHeaderView")
        collectionView.register(DetailReviewHeaderView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: "DetailReviewHeaderView")
        
        return collectionView
    }()
    
    private lazy var collectionViewLayout: UICollectionViewLayout = {
        return UICollectionViewCompositionalLayout { [weak self] section, _ -> NSCollectionLayoutSection? in
            let itemType = self?.sections[section].itemType
            switch itemType {
            case .main:
                return self?.createMainSection()
                
            case .infoShortItem:
                return self?.createInfoShortItemSection()
                
            case .screenShots:
                return self?.createScreenShotItemSection()
                
            case .textDescription:
                return self?.createTextInfoWithHeaderSection()
                
            case .textInfo:
                return self?.createTextInfoWithHeaderSection()
                
            case .review:
                return self?.createReviewSection()
                
            case .infoListItem:
                return self?.createInfoListItemSection()
                
            default:
                return nil
            }
        }
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        setupLayout()
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
        
        navigationItem.rightBarButtonItems = [navigationButton]
        navigationItem.titleView = navigationAppView
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setupNavigationBar()
    }
    
    private func setupNavigationBar() {
        navigationController?.navigationBar.prefersLargeTitles = false
        navigationItem.titleView?.isHidden = isHiddenNavigationBarAppInfo
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
        let groupSize = NSCollectionLayoutSize(widthDimension: .absolute(self.view.frame.width - sectionMargin), heightDimension: .absolute(100))
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
        let groupSize = NSCollectionLayoutSize(widthDimension: .absolute((collectionView.frame.width - sectionMargin) / 1.5), heightDimension: .absolute(500))
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
        let groupSize = NSCollectionLayoutSize(widthDimension: .absolute(collectionView.frame.width - sectionMargin), heightDimension: .estimated(1))
//        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitem: item, count: 1)
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
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
    
    private func createInfoListItemSection() -> NSCollectionLayoutSection {
        let itemMargin: CGFloat = 5
        let sectionMargin: CGFloat = 15
        
        //item
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .estimated(1))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        item.contentInsets = .init(top: itemMargin, leading: itemMargin, bottom: itemMargin, trailing: itemMargin)
        
        //group
        let width = self.view.frame.width - sectionMargin
        let groupSize = NSCollectionLayoutSize(widthDimension: .absolute(width), heightDimension: .estimated(1))
        let group = NSCollectionLayoutGroup.vertical(layoutSize: groupSize, subitems: [item])
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
        return sections.count
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return sections[section].items?.count ?? 1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let item = item else {
            return UICollectionViewCell()
        }
        
        let section = sections[indexPath.section]
        
        switch section.itemType {
        case .main:
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "DetailMainCollectionViewCell", for: indexPath) as? DetailMainCollectionViewCell else {
                return UICollectionViewCell()
            }
            cell.setupItem(item: item)
            return cell
            
        case .infoShortItem:
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "DetailInfoShortItemCollectionViewCell", for: indexPath) as? DetailInfoShortItemCollectionViewCell else {
                return UICollectionViewCell()
            }
            if let sectionItem = section.items?[indexPath.row] as? String {
                cell.setupItem(item: sectionItem)
            }
            return cell
            
        case .textDescription:
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "DetailTextInfoCollectionViewCell", for: indexPath) as? DetailTextInfoCollectionViewCell else {
                return UICollectionViewCell()
            }
            cell.setupItem(text: item.resultDescription)
            cell.collectionViewLayoutUpdateDelegate = self
            return cell
            
        case .screenShots:
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "DetailScreenShotCollectionViewCell", for: indexPath) as? DetailScreenShotCollectionViewCell else {
                return UICollectionViewCell()
            }
            if let screenUrl = section.items?[indexPath.row] as? String {
                cell.setupItem(screenUrl: screenUrl)
            }
            return cell
            
        case .textInfo:
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "DetailTextInfoCollectionViewCell", for: indexPath) as? DetailTextInfoCollectionViewCell else {
                return UICollectionViewCell()
            }
            cell.setupItem(text: item.releaseNotes ?? "-")
            cell.collectionViewLayoutUpdateDelegate = self
            return cell
            
        case .review:
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "DetailReviewCollectionViewCell", for: indexPath) as? DetailReviewCollectionViewCell else {
                return UICollectionViewCell()
            }
            if let supportedDevice = section.items?[indexPath.row] as? String {
                cell.setupItem(text: supportedDevice)
            }
            return cell
            
        case .newFeatureInfo:
            return UICollectionViewCell()
            
        case .infoListItem:
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "DetailInfoInfoCollectionViewCell", for: indexPath) as? DetailInfoInfoCollectionViewCell else {
                return UICollectionViewCell()
            }
            
            cell.indexPath = indexPath
            
            let section = sections[indexPath.section]
            if let itemName = section.itemNames?[indexPath.row],
               let item = section.items?[indexPath.row] as? String,
               let isExpanded = section.isExpanded?[indexPath.row] {
                cell.setupItem(infoName: itemName, shortInfo: item, detailInfo: item, isExpanded: isExpanded)
            }
            
            cell.collectionViewLayoutUpdateDelegate = self
            return cell
        }
    }

    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        switch kind {
        case UICollectionView.elementKindSectionHeader:
            let section = sections[indexPath.section]
            switch section.headerType {
                
            case .line:
                guard let headerView = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: "DetailLineHeaderView", for: indexPath) as? DetailLineHeaderView else {
                    return UICollectionReusableView()
                }
                return headerView
                
            case .largeTitleWithButton:
                guard let headerView = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: "DetailLargeTitleWithButtonHeaderView", for: indexPath) as? DetailLargeTitleWithButtonHeaderView else {
                    return UICollectionReusableView()
                }
                
                if section.itemType == .textInfo {
                    headerView.setupLargeTitleData(largeTitleText: "app_new_feature".localized, largeButtonText: "app_version_history".localized)
                } else if section.itemType == .infoListItem {
                    headerView.setupLargeTitleData(largeTitleText: "정보", largeButtonText: nil)
                }
                return headerView
                
            case .review:
                guard let headerView = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: "DetailReviewHeaderView", for: indexPath) as? DetailReviewHeaderView else {
                    return UICollectionReusableView()
                }
                headerView.setupLargeTitleData(
                    largeTitleText: "app_review_title".localized,
                    largeButtonText: "show_all_title".localized
                )
                if let item = item {
                    headerView.setupItem(
                        rate: String(round(item.averageUserRating * 10)/10),
                        ratingCount: item.userRatingCount
                    )
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

extension DetailViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let section = sections[indexPath.section]
        
        //TODO: didSelect
        switch section.itemType {
        case .screenShots:
            guard let screenShots = section.items as? [String] else {
                return
            }
            let detailScreenshotsVC = DetailScreenShotsViewController()
            detailScreenshotsVC.screenShots = screenShots
            detailScreenshotsVC.startRow = indexPath.row
            present(detailScreenshotsVC, animated: true, completion: nil)
            
        default:
            return
        }
        
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let yOffset = scrollView.contentOffset.y
        isHiddenNavigationBarAppInfo = yOffset < 0
    }
}

extension DetailViewController: CollectionViewLayoutUpdateDelegate {
    func collectionViewLayoutUpdate() {
        self.collectionView.collectionViewLayout.invalidateLayout()
    }
    
    func expandCell(indexPath: IndexPath) {
        sections[indexPath.section].isExpanded?[indexPath.row] = true
    }
}
