//
//  SearchResultViewController.swift
//  AppleAppStore
//
//  Created by skillist on 2021/12/13.
//

import UIKit

class SearchResultViewController: UIViewController {
    
    var items: [SearchItem] = []
    
    private lazy var collectionView: UICollectionView = {
        var collectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
        collectionView.dataSource = self
        collectionView.delegate = self
//        collectionView.delega
        
        collectionView.register(SearchResultAppCollectionViewCell.self, forCellWithReuseIdentifier: "SearchResultAppCollectionViewCell")
        return collectionView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupLayout()
        setData()
    }
    
    private func setupLayout() {
        view.addSubview(collectionView)
        
        collectionView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
}

extension SearchResultViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return items.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let item = items[indexPath.row]
        switch item.itemType {
        case .app:
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "SearchResultAppCollectionViewCell", for: indexPath) as? SearchResultAppCollectionViewCell else {
                return UICollectionViewCell()
            }
            return cell
            
        case .etc:
            return UICollectionViewCell()
        }
    }
}

extension SearchResultViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        return CGSize(width: collectionView.frame.width - 40, height: 300)
    }
    
}

extension SearchResultViewController {
    func setData() {
        items.append(
            SearchItem(itemType: .app, item: "asd")
        )
        
        collectionView.reloadData()
    }
}
