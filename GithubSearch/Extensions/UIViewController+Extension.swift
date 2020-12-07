//
//  UIViewController+Extension.swift
//  GithubSearch
//
//  Created by Aleksandr Maltsev on 06.12.2020.
//

import UIKit

extension UIViewController {
	
	func showAlert(title: String, message: String) {
		let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
		let okAction = UIAlertAction(title: "OK", style: .default)
		alert.addAction(okAction)
		present(alert, animated: true)
	}
	
}
