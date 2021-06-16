//
//  SearchResultsViewController.swift
//  GitSearch
//
//  Created by Jacky Lao on 6/15/21.
//

import UIKit

class SearchResultsViewController: UIViewController, StoryboardInstantiatable {

    @IBOutlet weak var tableView: UITableView!
    private var results: [Repository] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    func updateResults(_ results: [Repository]) {
        self.results = results
        tableView.reloadData()
    }
}

extension SearchResultsViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        results.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: ResultTableViewCell.identifier, for: indexPath) as! ResultTableViewCell
        let result = results[indexPath.row]
        cell.titleLabel.text = result.fullName
        return cell
    }
    
}
