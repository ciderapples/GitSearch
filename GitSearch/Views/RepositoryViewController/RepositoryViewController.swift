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
    private var activityIndicator = UIActivityIndicatorView()
    
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
        
        activityIndicator.center = self.view.center
        activityIndicator.hidesWhenStopped = true
        activityIndicator.style = .medium
        
        view.addSubview(activityIndicator)
        
        webView?.navigationDelegate = self
        
        guard let link = URL(string: urlString) else { return }
        let request = URLRequest(url: link)
        webView.load(request)
    }
}

extension RepositoryViewController: WKNavigationDelegate {
    func webView(_ webView: WKWebView, didStartProvisionalNavigation navigation: WKNavigation!) {
        activityIndicator.startAnimating()
    }
    
    func webView(_ webView: WKWebView, didCommit navigation: WKNavigation!) {
        activityIndicator.stopAnimating()
    }
    
    func webView(_ webView: WKWebView, didFail navigation: WKNavigation!, withError error: Error) {
        activityIndicator.stopAnimating()
    }
}
