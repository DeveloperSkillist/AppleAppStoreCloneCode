//
//  SearchViewController.swift
//  AppleAppStore
//
//  Created by skillist on 2021/12/13.
//

import UIKit

class SearchViewController: UIViewController {
    var searchResultVC = SearchResultViewController()
    var searchHistory: [String] = []
    let historyQuerys = "historyQuerys"
    
    private lazy var searchController: UISearchController = {
        var searchController = UISearchController(searchResultsController: searchResultVC)
        searchResultVC.tempDelegate = self
        searchController.searchBar.placeholder = "search_placeholder".localized
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.hidesNavigationBarDuringPresentation = false
        searchController.delegate = self
        
        searchController.searchBar.delegate = self
        searchController.searchBar.setNeedsLayout()
        return searchController
    }()
    
    private lazy var historyCollectionView: UICollectionView = {
        var collectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(SearchHistoryCollectionViewCell.self, forCellWithReuseIdentifier: "SearchHistoryCollectionViewCell")
        return collectionView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        setupNavigationBar()
        setupLayout()
        setupHistoryQuerys()
    }
    
    private func setupLayout() {
        view.backgroundColor = .systemBackground
        
        [
            historyCollectionView
        ].forEach {
            view.addSubview($0)
        }
        
        historyCollectionView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
    
    private func setupHistoryQuerys() {
        searchHistory = UserDefaults.standard.stringArray(forKey: "historyQuerys") ?? []
        historyCollectionView.reloadData()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        setupNavigationBar()
    }
    
    func setupNavigationBar() {
//        navigationController?.navigationItem.searchController = searchController
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.title = "search_title".localized
//        navigationItem.hidesSearchBarWhenScrolling = false
        navigationItem.searchController = searchController
//        searchController.isActive = true
//        navigationItem.hidesSearchBarWhenScrolling = true
        navigationItem.largeTitleDisplayMode = .automatic

        definesPresentationContext = true
    }
}

extension SearchViewController: UISearchControllerDelegate {
    
}

extension SearchViewController: UISearchBarDelegate {
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let searchText = searchBar.text else {
            return
        }
        updateSearchHistory(query: searchText)
        searchResultVC.searchItems(searchText: searchText)
    }
    
    func updateSearchHistory(query: String) {
        if let row = searchHistory.firstIndex(of: query) {
            searchHistory.remove(at: row)
        }
        
        if searchHistory.count >= 10 {
            searchHistory.removeLast()
        }
        
        searchHistory.insert(query, at: 0)
        
        UserDefaults.standard.set(searchHistory, forKey: historyQuerys)
        historyCollectionView.reloadData()
    }
}

extension SearchViewController: DetailAppVCDelegate {
    func pushDetailVC(item: SearchItemResult) {
        let detailVC = DetailViewController()
        detailVC.item = item
        navigationController?.pushViewController(detailVC, animated: true)
    }
}

extension SearchViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return searchHistory.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "SearchHistoryCollectionViewCell", for: indexPath) as? SearchHistoryCollectionViewCell else {
            return UICollectionViewCell()
        }
        
        cell.setupItem(historyString: searchHistory[indexPath.row])
        return cell
    }
}

extension SearchViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width, height: 50)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let query = searchHistory[indexPath.row]
        searchController.searchBar.text = query
        searchController.searchBar.becomeFirstResponder()
        searchBarSearchButtonClicked(searchController.searchBar)
    }
}
