//
//  Storyboards.swift
//  GithubSearch
//
//  Created by Aleksandr Maltsev on 06.12.2020.
//

import UIKit

extension UIStoryboard {
	enum Storyboard: String {
		case repositories = "Repositories"
		
		var name: String {
			self.rawValue
		}
	}
}

extension UIStoryboard {
	convenience init(storyboard: Storyboard, bundle: Bundle? = nil) {
		self.init(name: storyboard.name, bundle: bundle)
	}
}
