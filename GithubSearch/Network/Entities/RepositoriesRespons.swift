//
//  RepositoriesRespons.swift
//  GithubSearch
//
//  Created by Aleksandr Maltsev on 06.12.2020.
//

import Foundation

struct RepositoriesResponse: Codable {
	let totalCount: Int?
	let incompleteResults: Bool?
	let items: [RepositoryInfo]?
	
	enum CodingKeys: String, CodingKey {
		case totalCount = "total_count"
		case incompleteResults = "incomplete_results"
		case items
	}
}

struct RepositoryInfo: Codable {
	let name: String?
	let description: String?
	let stargazersCount: Int?
	
	enum CodingKeys: String, CodingKey {
		case name
		case description
		case stargazersCount = "stargazers_count"
	}
}

extension RepositoryInfo: RepositoryCellConfigerProtocol {
	var repoName: String {
		self.name ?? "No name"
	}
	
	var repoDescription: String {
		self.description ?? "No description"
	}
	
	
	var starsNumber: String {
		self.stargazersCount != nil ? "\(self.stargazersCount!)" : "no"
	}
}
