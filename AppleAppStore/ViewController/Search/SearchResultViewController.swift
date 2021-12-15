//
//  SearchResultViewController.swift
//  AppleAppStore
//
//  Created by skillist on 2021/12/13.
//

import UIKit

class SearchResultViewController: UIViewController {
    
    weak var tempDelegate: DetailAppVCDelegate?
    var items: [SearchItemResult] = []
    
    private lazy var collectionView: UICollectionView = {
        var collectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
        collectionView.dataSource = self
        collectionView.delegate = self
        
        collectionView.register(SearchResultAppCollectionViewCell.self, forCellWithReuseIdentifier: "SearchResultAppCollectionViewCell")
        return collectionView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigationBar()
        setupLayout()
        setData()
    }
    
    private func setupNavigationBar() {
        navigationItem.title = "search_title".localized
    }
    
    private func setupLayout() {
        view.addSubview(collectionView)
        
        collectionView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
    
    private func resetResult() {
        items = []
        collectionView.reloadData()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.isNavigationBarHidden = true
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        navigationController?.isNavigationBarHidden = false
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

//extension SearchResultViewController: UICollectionViewDelegate {
//
//}

extension SearchResultViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let item = items[indexPath.row]
        tempDelegate?.pushDetailVC(item: item)
        
//        let detailVC = DetailViewController()
        
//        navigationController?.pushViewController(detailVC, animated: true)
        
//        present(detailVC, animated: true, completion: nil)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        return CGSize(width: collectionView.frame.width - 32, height: 330)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 50
    }
    
}

extension SearchResultViewController {
    func setData() {
//        items.append(
//            SearchItem(itemType: .app, item: "asd")
//        )
//
//        items.append(
//            SearchItem(itemType: .app, item: "asd")
//        )
        
        collectionView.reloadData()
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
                    DispatchQueue.main.sync {
                        self?.collectionView.reloadData()
                    }
                } catch {
                    print("error: \(error)")
                }
                
            default:
                //TODO: error
                return
            }
        }
    }
}
