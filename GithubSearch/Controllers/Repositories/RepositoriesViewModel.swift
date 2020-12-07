//
//  RepositoriesViewModel.swift
//  GithubSearch
//
//  Created by Aleksandr Maltsev on 06.12.2020.
//

import UIKit

class RepositoriesViewModel: NSObject {
	
	var onErrorResponse: (() -> ())?
	var onUpdateRepositories: (() -> ())?
	private let pagesNumber = 2
	private let reposLimit = 30
	private var repositories: [RepositoryInfo] = []
	
	var repositoriesNumber: Int {
		self.repositories.count
	}
	
	private let requestsHandlingQueue = DispatchQueue(label: "mutatingRepositories")
	
	func repositoryInfoFor(index: Int) -> RepositoryCellConfigerProtocol? {
		let repositoryInfo = self.repositories[index]
		return repositoryInfo
	}
	
	func searchRepositoryBy(name: String) {
		self.splitRepositoryRequests(name: name)
	}
	
	private func clearRepositories() {
		self.repositories.removeAll()
	}
	
	private func splitRepositoryRequests(name: String) {
		let reposPerRequest: Int = self.reposLimit / self.pagesNumber
		let requestsRange = 1...self.pagesNumber
		self.clearRepositories()
		
		requestsRange.forEach { requestNumber in
			self.performRequestQueue(repoName: name,
									 requestNumber: requestNumber,
									 limit: reposPerRequest)
		}
	}
	
	private func performRequestQueue(repoName: String, requestNumber: Int, limit: Int) {
		let queue = DispatchQueue(label: "requestQueue.\(requestNumber)")
		queue.async {
			self.repositorySearchRequest(name: repoName, limit: limit, page: requestNumber) { repos in
				self.requestsHandlingQueue.async(flags: .barrier) {
					if !repos.isEmpty {
						self.add(newRepositories: repos)
					} else {
						self.onErrorResponse?()
					}
				}
			}
		}
	}
	
	private func add(newRepositories: [RepositoryInfo]) {
		if self.repositories.isEmpty {
			self.repositories = newRepositories
		} else {
			self.repositories.append(contentsOf: newRepositories)
			self.repositories.sort { $0.stargazersCount ?? 0 > $1.stargazersCount ?? 0 }
			self.onUpdateRepositories?()
		}
	}
	
	private func repositorySearchRequest(name: String, limit: Int, page: Int, _ handler: @escaping ([RepositoryInfo]) -> ()) {
		GithubRequests.findRepositoriesBy(name: name, limit: limit, page: page) { repos in
			handler(repos)
		}
	}
}
