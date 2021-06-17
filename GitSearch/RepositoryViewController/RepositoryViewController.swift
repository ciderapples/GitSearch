//
//  RepositoryViewController.swift
//  GitSearch
//
//  Created by Jacky Lao on 6/17/21.
//

import UIKit
import WebKit

final class RepositoryViewController: UIViewController, StoryboardInstantiatable {

    @IBOutlet weak var webView: WKWebView!
    
    private var urlString: String
    private var titleText: String

    required init?(coder: NSCoder, urlString: String, titleText: String) {
        self.urlString = urlString
        self.titleText = titleText
        super.init(coder: coder)
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        title = titleText
        
        navigationController?.navigationBar.prefersLargeTitles = false

        guard let link = URL(string: urlString) else { return }
        let request = URLRequest(url: link)
        webView.load(request)
    }
}

