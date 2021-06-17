//
//  ResultTableViewCell.swift
//  GitSearch
//
//  Created by Jacky Lao on 6/16/21.
//

import UIKit
import Kingfisher

final class ResultTableViewCell: UITableViewCell {
    
    @IBOutlet weak var avatarImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var detailLabel: UILabel!
    @IBOutlet weak var starCountLabel: UILabel!
    @IBOutlet weak var languageView: UIStackView!
    @IBOutlet weak var languageLabel: UILabel!
    
    static let identifier = "ResultTableViewCell"
    var repository: Repository? {
        didSet {
            if let repository = repository {
                let url = URL(string: repository.owner.avatarUrl)
                avatarImageView.kf.setImage(with: url)
                
                nameLabel.text = repository.owner.login
                titleLabel.text = repository.name
                if let description = repository.description {
                    detailLabel.isHidden = false
                    detailLabel.text = description
                } else {
                    detailLabel.isHidden = true
                }
                starCountLabel.text = "\(repository.watchers)"
                if let language = repository.language {
                    languageView.isHidden = false
                    languageLabel.text = language
                } else {
                    languageView.isHidden = true
                }
            }
        }
    }
}
