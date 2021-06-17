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
    
    func updateResults(_ results: [Repository]) {
        searchingView.isHidden = true
        if results.count > 0 {
            self.results = results
            tableView.reloadData()
            tableView.isHidden = false
        } else {
            tableView.isHidden = true
        }
    }
    
    @IBAction func search(_ sender: Any) {
        guard let text = searchText else { return }
        let vc = RepositoryListViewController.instantiate {
            RepositoryListViewController(coder: $0, searchText: text)
        }
        present(vc, animated: true, completion: nil)
    }
}

extension SearchResultsViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        results.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: ResultTableViewCell.identifier, for: indexPath) as! ResultTableViewCell
        cell.repository = results[indexPath.row]
        return cell
    }
    
}
