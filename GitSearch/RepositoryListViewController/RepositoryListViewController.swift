//
//  RepositoryListViewController.swift
//  GitSearch
//
//  Created by Jacky Lao on 6/17/21.
//

import UIKit

final class RepositoryListViewController: UIViewController, StoryboardInstantiatable {

    @IBOutlet weak var tableView: UITableView!
    private var searchText: String
    private var results: [Repository] = []
    private var totalCount = 0
    private var nextPage = 1
    private var perPage = "30"

    required init?(coder: NSCoder, searchText: String) {
        self.searchText = searchText
        super.init(coder: coder)
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        title = "Repositories"
        
        navigationController?.navigationBar.prefersLargeTitles = false
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.showActivityIndicator()

        fetchRepositories(with: "\(nextPage)") // Show first page
    }
    
    private func fetchRepositories(with page: String) {
        let repositoryRequest: RepositoriesRequest = .getRepositories(query: searchText, page: page, perPage: perPage)
        RemoteResourceLoader().load(networkRequest: repositoryRequest, resourceType: GetRepositoriesResponse.self) { [self] result in
            switch result {
            case .success(let response):
                nextPage = nextPage + 1
                totalCount = response.totalCount
                self.results.append(contentsOf: response.items)
                if results.count > 0 {
                    tableView.isHidden = false
                } else {
                    tableView.isHidden = true
                }
            case .failure(let error):
                print(error)
            }
            
            tableView.hideActivityIndicator()
        }
    }
}

extension RepositoryListViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return results.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: ResultTableViewCell.identifier, for: indexPath) as! ResultTableViewCell
        cell.repository = results[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if indexPath.row == results.count - 1  { // Last cell, load more content
            if results.count < totalCount {
                fetchRepositories(with: "\(nextPage)")
            }
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        // Show webview detail
        let repository = results[indexPath.row]
        let vc = RepositoryViewController.instantiate {
            RepositoryViewController(coder: $0, urlString: repository.htmlUrl, titleText: repository.name)
        }
        self.navigationController?.pushViewController(vc, animated: true)
    }
}
