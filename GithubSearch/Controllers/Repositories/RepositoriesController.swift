//
//  ViewController.swift
//  GithubSearch
//
//  Created by Aleksandr Maltsev on 05.12.2020.
//

import UIKit

class RepositoriesViewController: UIViewController {
	
	@IBOutlet weak var searchTextField: UITextField!
	@IBOutlet weak var reposTableView: UITableView!
	
	@IBAction func searchButtonDidTap(_ sender: UIButton) {
		self.searchCurrentText()
		self.searchTextField.resignFirstResponder()
	}
	
	private let viewModel = RepositoriesViewModel()
	
	private var cellIdentifier: String {
		RepositroyCell.nibName
	}
	
	private var searchFieldText: String? {
		self.searchTextField.text
	}
	
	//MARK:- Lifecycle
	override func viewDidLoad() {
		super.viewDidLoad()
		
		self.configureTableView()
		self.searchTextField.delegate = self
		
		self.configureViewModel()
	}
	
	private func configureTableView() {
		self.reposTableView.delegate = self
		self.reposTableView.dataSource = self
		self.registerCell()
	}

	private func registerCell() {
		let repoCell = UINib(nibName: RepositroyCell.nibName, bundle: nil)
		self.reposTableView.register(repoCell,
									 forCellReuseIdentifier: self.cellIdentifier)
	}
	
	//MARK:- Logic
	private func configureViewModel() {
		self.viewModel.onUpdateRepositories = { [weak self] in
			DispatchQueue.main.async {
				self?.reposTableView.reloadData()
			}
		}
		
		self.viewModel.onErrorResponse = { [weak self] in
			DispatchQueue.main.async {
				self?.showAlert(title: "Error", message: "Ooops, something went wrong. Sorry(")
			}
		}
	}
	
	private func searchCurrentText() {
		guard let text = self.searchFieldText else { return }
		
		self.viewModel.searchRepositoryBy(name: text)
	}
}

//MARK:- TableView
extension RepositoriesViewController: UITableViewDelegate, UITableViewDataSource {
	
	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return self.viewModel.repositoriesNumber
	}
	
	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		let cell = tableView.dequeueReusableCell(withIdentifier: self.cellIdentifier) as! RepositroyCell
		let repositoryInfo = self.viewModel.repositoryInfoFor(index: indexPath.row)
		if let repoInfo = repositoryInfo {
			cell.configure(repoInfo)
		}
		return cell
	}
}

//MARK:- TextField
extension RepositoriesViewController: UITextFieldDelegate {
	
	func textFieldShouldReturn(_ textField: UITextField) -> Bool {
		self.searchCurrentText()
		textField.resignFirstResponder()
		return true
	}
}
