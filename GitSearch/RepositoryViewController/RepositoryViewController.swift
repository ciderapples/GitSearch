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
    
    required init?(coder: NSCoder, urlString: String) {
        self.urlString = urlString
        super.init(coder: coder)
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        guard let link = URL(string: urlString) else { return }
        let request = URLRequest(url: link)
        webView.load(request)
    }
}

