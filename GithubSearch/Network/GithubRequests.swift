//
//  GithubRequests.swift
//  GithubSearch
//
//  Created by Aleksandr Maltsev on 06.12.2020.
//

import Foundation
import Alamofire

class GithubRequests {
	
	private static let baseUrl = "https://api.github.com"
	
	enum SortOrderParameter: String {
		case ascending = "asc"
		case descending = "desc"
		
		var name: String {
			self.rawValue
		}
	}
	
	static func findRepositoriesBy(name: String, order: SortOrderParameter = .descending, limit: Int, page: Int, _ handler: @escaping ([RepositoryInfo]) -> ()) {
		let parameters = [
			"q" : "\(name)",
			"per_page" : "\(limit)",
			"sort" : "stars",
			"order" : order.name,
			"page" : "\(page)"
		]
		let url = self.baseUrl + "/search/repositories"
		
		AF.request(url, parameters: parameters).responseDecodable(of: RepositoriesResponse.self) { response in
			if let repos = response.value {
				let items = repos.items ?? []
				handler(items)
			} else {
				print(response.error?.localizedDescription ?? "No error")
				handler([])
			}
		}
	}
}
