//
//  SearchResultsViewController.swift
//  GitSearch
//
//  Created by Jacky Lao on 6/15/21.
//

import UIKit

final class SearchResultsViewController: UIViewController, StoryboardInstantiatable {
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var searchingView: UIView!
    @IBOutlet weak var searchButton: UIButton!
    @IBOutlet weak var searchingLabel: UILabel!
    private var results: [Repository] = []
    private var searchText: String?
    private var totalRepoCount: Int = 0
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        
        searchButton.layer.cornerRadius = 8
    }
    
    func updateSearchText(_ text: String) {
        searchingView.isHidden = false
        searchingLabel.text = "🔎 Search Repositories with \"\(text)\""
        searchText = text
    }
    
    func updateResults(_ results: [Repository], count: Int) {
        searchingView.isHidden = true
        if results.count > 0 {
            self.results = results
            totalRepoCount = count
            tableView.reloadData()
            tableView.isHidden = false
        } else {
            tableView.isHidden = true
        }
    }
    
    @IBAction func search(_ sender: Any) {
        showAllRepositories()
    }
    
    private func showAllRepositories() {
        guard let text = searchText else { return }
        let vc = RepositoryListViewController.instantiate {
            RepositoryListViewController(coder: $0, searchText: text)
        }
        
        if let parent = parent as? UISearchController {
            if let searchVC = parent.searchResultsUpdater as? SearchViewController {
                searchVC.navigationController?.pushViewController(vc, animated: true)
            }
        }
    }
    
}

extension SearchResultsViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if section == 0 {
            return "Repositories"
        } else {
            return ""
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if totalRepoCount > 3 {
            return results.count + 1 // Add +1 row for the "See More" cell
        } else {
            return results.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row < 3 {
            let cell = tableView.dequeueReusableCell(withIdentifier: ResultTableViewCell.identifier, for: indexPath) as! ResultTableViewCell
            cell.repository = results[indexPath.row]
            return cell
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "SeeMoreTableCell", for: indexPath)
            cell.textLabel?.text = "See \(totalRepoCount) more repositories"
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.row < 3 {
            // Show webview detail
            let repository = results[indexPath.row]
            let vc = RepositoryViewController.instantiate {
                RepositoryViewController(coder: $0, urlString: repository.htmlUrl, titleText: repository.name)
            }
            
            if let parent = parent as? UISearchController {
                if let searchVC = parent.searchResultsUpdater as? SearchViewController {
                    searchVC.navigationController?.pushViewController(vc, animated: true)
                }
            }
        } else {
            showAllRepositories()
        }
    }
}
