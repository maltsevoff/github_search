//
//  RepoTableViewCell.swift
//  GithubSearch
//
//  Created by Aleksandr Maltsev on 06.12.2020.
//

import UIKit

class RepositroyCell: UITableViewCell {
	
	static let nibName = "RepositoryCell"
	
	@IBOutlet private weak var nameLabel: UILabel!
	@IBOutlet private weak var starsNumberLabel: UILabel!
	@IBOutlet private weak var descriptionLabel: UILabel!
	
	override func awakeFromNib() {
		super.awakeFromNib()
		self.selectionStyle = .none
	}
	
	func configure(_ repositoryInfo: RepositoryCellConfigerProtocol) {
		self.setStarsNumber(repositoryInfo.starsNumber)
		self.nameLabel.text = repositoryInfo.repoName
		self.descriptionLabel.text = repositoryInfo.repoDescription
	}
	
	func setStarsNumber(_ number: String) {
		let numberString = number + "⭐"
		self.starsNumberLabel.text = numberString
	}
}
