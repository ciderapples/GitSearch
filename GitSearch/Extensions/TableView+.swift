//
//  TableView+.swift
//  GitSearch
//
//  Created by Jacky Lao on 6/17/21.
//

import UIKit

extension UITableView {
    func showActivityIndicator() {
        let activityView = UIActivityIndicatorView(style: .medium)
        backgroundView = activityView
        activityView.startAnimating()
    }
    
    func hideActivityIndicator() {
        backgroundView = nil
    }
}
