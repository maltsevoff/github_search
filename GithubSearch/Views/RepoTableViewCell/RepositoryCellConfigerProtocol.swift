//
//  RepositoryCellConfigerProtocol.swift
//  GithubSearch
//
//  Created by Aleksandr Maltsev on 06.12.2020.
//

import Foundation

protocol RepositoryCellConfigerProtocol {
	var repoName: String { get }
	var starsNumber: String { get }
	var repoDescription: String { get }
}
