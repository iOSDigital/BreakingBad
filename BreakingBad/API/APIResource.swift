//
//  APIResource.swift
//  BreakingBad
//
//  Created by Paul Derbyshire on 17/05/2021.
//

import Foundation

protocol APIResource {
	associatedtype ModelType: Decodable
	var path: String { get }
}

extension APIResource {
	var url: URL {
		var components = URLComponents(string: "https://www.breakingbadapi.com/api")!
		components.path = components.path.appending(path)
		components.queryItems = [
			URLQueryItem(name: "limit", value: "100"),
			URLQueryItem(name: "offset", value: "0")
		]
		return components.url!
	}
}
