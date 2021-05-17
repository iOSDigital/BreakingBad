//
//  APIRequest.swift
//  BreakingBad
//
//  Created by Paul Derbyshire on 17/05/2021.
//

import Foundation

enum APIRequestError: Error {
	case DecodeError
}

class APIRequest<Resource: APIResource> {
	let resource: Resource
	
	init(resource: Resource) {
		self.resource = resource
	}
}

extension APIRequest: APINetworkRequest {
	
	func decode(_ data: Data) throws -> [Resource.ModelType]? {
		let decoder = JSONDecoder()
		
		do {
			let items = try decoder.decode([Resource.ModelType].self, from: data)
			return items
		} catch {
			print("Error: \(APIRequestError.DecodeError) : \(error)")
			throw(APIRequestError.DecodeError)
		}
	}
	
	func execute(withCompletion completion: @escaping ([Resource.ModelType]?) -> Void) {
		load(resource.url, withCompletion: completion)
	}

}
