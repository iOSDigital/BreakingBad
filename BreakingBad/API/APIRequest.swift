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
struct APIRequestPreferences {
	static let ServerRefreshTimeInterval = TimeInterval(3600) //1 hour
}


extension APIRequest: APINetworkRequest {
	
	func decode(_ data: Data) throws -> [Resource.ModelType]? {
		let decoder = JSONDecoder()
		
		do {
			// Save the data
			let saveLocation = FileManager.getDocumentsDirectoryURL().appendingPathComponent(resource.modelName).appendingPathExtension("data")
			try data.write(to: saveLocation)
			
			let items = try decoder.decode([Resource.ModelType].self, from: data)
			return items
		} catch {
			print("Error: \(APIRequestError.DecodeError) : \(error)")
			throw(APIRequestError.DecodeError)
		}
	}
	
	func execute(withCompletion completion: @escaping ([Resource.ModelType]?) -> Void) {
		
		// See if a cached version exists
		let cacheURL = FileManager.getDocumentsDirectoryURL().appendingPathComponent(resource.modelName).appendingPathExtension("data")
		if FileManager.default.fileExists(atPath: cacheURL.path) {
			let attributes = try? FileManager.default.attributesOfItem(atPath: cacheURL.path)
			let creationDate = attributes?[.modificationDate] as! Date
			let interval = Date().timeIntervalSinceReferenceDate - creationDate.timeIntervalSinceReferenceDate
			if interval < APIRequestPreferences.ServerRefreshTimeInterval {
				print("Cached version exists: \(cacheURL.path)")
				if let data = try? Data(contentsOf: cacheURL) {
					completion(try? decode(data))
				}
				return
			}
		}
		
		// Otherwise, load from API
		print("Cached version does not exist, load from API")
		load(resource.url, withCompletion: completion)
	}
	
	func post(_ data: Data, withCompletion completion: @escaping (Result<HTTPURLResponse, APIError>) -> Void) {
		post(resource.url, data: data, withCompletion: completion)
	}


}
