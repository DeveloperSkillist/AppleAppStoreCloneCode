//
//  SearchResultViewController.swift
//  AppleAppStore
//
//  Created by skillist on 2021/12/13.
//

import UIKit

class SearchResultViewController: UIViewController {
    
    weak var detailAppDelegate: DetailAppVCDelegate?
    var items: [SearchItemResult] = [] {
        didSet {
            DispatchQueue.main.async {
                self.collectionView.reloadData()
                
                let isEmpty = self.items.count == 0
                self.collectionView.isHidden = isEmpty
                self.emptyView.isHidden = !isEmpty
            }
        }
    }
    
    private lazy var emptyView: UIView = {
        var emptyLabel = UILabel()
        emptyLabel.textColor = .label
        emptyLabel.text = "search_empty".localized
        emptyLabel.font = .systemFont(ofSize: 20)
        emptyLabel.numberOfLines = 0
        
        var emptyView = UIView()
        emptyView.backgroundColor = .systemBackground
        emptyView.addSubview(emptyLabel)
        emptyView.isHidden = true
        
        emptyLabel.snp.makeConstraints {
            $0.center.equalToSuperview().inset(20)
        }
        
        return emptyView
    }()
    
    private lazy var collectionView: UICollectionView = {
        var collectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.keyboardDismissMode = .onDrag
        collectionView.register(SearchResultAppCollectionViewCell.self, forCellWithReuseIdentifier: "SearchResultAppCollectionViewCell")
        return collectionView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupLayout()
    }
    
    private func setupLayout() {
        [
            collectionView,
            emptyView
        ].forEach {
            view.addSubview($0)
        }
        
        collectionView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        
        emptyView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
}

extension SearchResultViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return items.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "SearchResultAppCollectionViewCell", for: indexPath) as? SearchResultAppCollectionViewCell else {
            return UICollectionViewCell()
        }
        let item = items[indexPath.row]
        cell.setupItem(item: item)
        return cell
    }
}

extension SearchResultViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let item = items[indexPath.row]
        detailAppDelegate?.pushDetailVC(item: item)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        return CGSize(width: collectionView.frame.width - 32, height: 330)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 50
    }
}

extension SearchResultViewController {
    func searchItems(searchText: String) {
        resetResult()
        
        ItunesAPI.searchApps(term: searchText) { [weak self] data, response, error in
            guard error == nil,
                  let response = response as? HTTPURLResponse,
                  let data = data else {
                      //TODO: error
                      return
                  }
            switch response.statusCode {
            case (200...299):
                do {
                    let searchedItems = try JSONDecoder().decode(SearchResult.self, from: data)
                    
                    print("searchedItems : \(searchedItems)")
                    self?.items = searchedItems.results
                } catch {
                    print("error: \(error)")
                }
                
            default:
                //TODO: error
                return
            }
        }
    }
    
    private func resetResult() {
        items = []
        
        collectionView.isHidden = true
        emptyView.isHidden = true
    }
}
