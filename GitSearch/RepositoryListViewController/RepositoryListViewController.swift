//
//  RepositoryListViewController.swift
//  GitSearch
//
//  Created by Jacky Lao on 6/17/21.
//

import UIKit

final class RepositoryListViewController: UIViewController, StoryboardInstantiatable {

    private var searchText: String
    
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
    }
}
