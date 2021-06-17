//
//  ResultTableViewCell.swift
//  GitSearch
//
//  Created by Jacky Lao on 6/16/21.
//

import UIKit

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
                nameLabel.text = repository.owner.login
                titleLabel.text = repository.name
                detailLabel.text = repository.description ?? "jjj"
                starCountLabel.text = "\(repository.watchers)"
                languageView.isHidden = true
                guard let language = repository.language else { return }
                languageView.isHidden = false
                languageLabel.text = language
            }
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        
    }
}
