//
//  SearchViewController.swift
//  GitSearch
//
//  Created by Jacky Lao on 6/15/21.
//

import UIKit

final class SearchViewController: UIViewController, StoryboardInstantiatable {

    private let searchResultsViewController = SearchResultsViewController.instantiate()
    private var searchController = UISearchController()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        title = "GitSearch"
        
        searchController = UISearchController(searchResultsController: searchResultsViewController)
        searchController.searchBar.placeholder = "Search"
        searchController.searchBar.delegate = self
        searchController.searchResultsUpdater = self
        searchController.hidesNavigationBarDuringPresentation = true
        navigationItem.searchController = searchController
        definesPresentationContext = true
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.prefersLargeTitles = true
    }
    
    private func search(text: String) {
        searchController.searchBar.text = text
        searchController.isActive = true
        searchController.searchBar.resignFirstResponder()
        
        searchResultsViewController.quickSearch(text)
    }
}

extension SearchViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let text = searchBar.text else { return }
        search(text: text)
    }
}

extension SearchViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        guard let text = searchController.searchBar.text, !text.isEmpty else { return }
        searchResultsViewController.updateSearchText(text)
    }
}

