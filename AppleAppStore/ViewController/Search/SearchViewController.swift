//
//  SearchViewController.swift
//  AppleAppStore
//
//  Created by skillist on 2021/12/13.
//

import UIKit

class SearchViewController: UIViewController {
    
    private lazy var searchController: UISearchController = {
        var searchController = UISearchController(searchResultsController: SearchResultViewController())
        searchController.searchBar.placeholder = "search_placeholder".localized
        searchController.obscuresBackgroundDuringPresentation = false

        searchController.delegate = self
        searchController.hidesNavigationBarDuringPresentation = false
        searchController.searchBar.delegate = self
        searchController.searchBar.setNeedsLayout()
        return searchController
    }()
    
    private lazy var collectionView: UICollectionView = {
        var collectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
//        collectionView.backgroundColor = .orange
        return collectionView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupNavigationBar()
        
        
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
        
//        setupNavigationBar()
    }
    
    func setupNavigationBar() {
//        navigationController?.navigationItem.searchController = searchController
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.title = "search_title".localized
//        navigationItem.hidesSearchBarWhenScrolling = false
        navigationItem.searchController = searchController
//        searchController.isActive = true
        navigationItem.hidesSearchBarWhenScrolling = true

        definesPresentationContext = true
        
        
    }
}

extension SearchViewController: UISearchControllerDelegate {
    
}

extension SearchViewController: UISearchBarDelegate {
    
}
