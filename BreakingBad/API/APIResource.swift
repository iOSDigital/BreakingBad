//
//  APIResource.swift
//  BreakingBad
//
//  Created by Paul Derbyshire on 17/05/2021.
//

import Foundation

protocol APIResource {
	var modelName: String { get }
	associatedtype ModelType: Decodable
	var path: String { get }
	var queryItems: [URLQueryItem]? { get }
}

extension APIResource {
	var url: URL {
		var components = URLComponents(string: "https://www.breakingbadapi.com/api")!
		components.path = components.path.appending(path)
		components.queryItems = queryItems
		return components.url!
	}
}
