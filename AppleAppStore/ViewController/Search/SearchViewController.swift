//
//  SearchViewController.swift
//  AppleAppStore
//
//  Created by skillist on 2021/12/13.
//

import UIKit

class SearchViewController: UIViewController {
    var searchResultVC = SearchResultViewController()
    
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
    
    private lazy var collectionView: UICollectionView = {
        var collectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
        return collectionView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        setupNavigationBar()
        setupLayout()
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
        
        searchResultVC.searchItems(searchText: searchText)
    }
}

extension SearchViewController: DetailAppVCDelegate {
    func pushDetailVC(item: SearchItemResult) {
        let detailVC = DetailViewController()
        detailVC.item = item
        navigationController?.pushViewController(detailVC, animated: true)
    }
}
