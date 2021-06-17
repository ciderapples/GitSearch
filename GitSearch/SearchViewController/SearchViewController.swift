//
//  SearchViewController.swift
//  GitSearch
//
//  Created by Jacky Lao on 6/15/21.
//

import UIKit

final class SearchViewController: UIViewController, StoryboardInstantiatable {

    let searchResultsViewController = SearchResultsViewController.instantiate()
    var searchController = UISearchController()
    override func viewDidLoad() {
        super.viewDidLoad()

        title = "GitSearch"
        
        searchController = UISearchController(searchResultsController: searchResultsViewController)
        searchController.searchBar.placeholder = "Search"
        searchController.searchBar.delegate = self
        searchController.searchResultsUpdater = self
        navigationItem.searchController = searchController
        definesPresentationContext = true
    }

    private func search(term: String) {
        searchController.searchBar.text = term
        searchController.isActive = true
        searchController.searchBar.resignFirstResponder()
        
        let repositoryRequest: RepositoriesRequest = .getRepositories(query: term, page: "1", perPage: "3")
        
        RemoteResourceLoader().load(networkRequest: repositoryRequest, resourceType: GetRepositoriesResponse.self) { result in
            switch result {
            case .success(let response):
                self.searchResultsViewController.updateResults(response.items, count: response.totalCount)
            case .failure(let error):
                print(error)
            }
        }
    }
}

extension SearchViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        searchResultsViewController.updateSearchText(searchText)
    }

    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let text = searchBar.text else { return }
        search(term: text)
    }
}

extension SearchViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        guard let text = searchController.searchBar.text, !text.isEmpty else { return }
    }
}

