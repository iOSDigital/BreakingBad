//
//  APINetworkRequest.swift
//  BreakingBad
//
//  Created by Paul Derbyshire on 17/05/2021.
//

import Foundation

protocol APINetworkRequest: AnyObject {
	associatedtype ModelType
	func decode(_ data: Data) throws -> ModelType?
	func execute(withCompletion completion: @escaping (ModelType?) -> Void)
}

extension APINetworkRequest {
	func load(_ url: URL, withCompletion completion: @escaping (ModelType?) -> Void) {
		let task = URLSession.shared.dataTask(with: url) { [weak self] (data, response , error) -> Void in
			
			guard let data = data, let value = try? self?.decode(data) else {
				DispatchQueue.main.async { completion(nil) }
				return
			}
			DispatchQueue.main.async { completion(value) }
		}
		task.resume()
	}
}
