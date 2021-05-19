//
//  APINetworkRequest.swift
//  BreakingBad
//
//  Created by Paul Derbyshire on 17/05/2021.
//

import Foundation

public enum APIError: Error {
	case PostError
	case URLSessionError
}

protocol APINetworkRequest: AnyObject {
	associatedtype ModelType
	func decode(_ data: Data) throws -> ModelType?
	func execute(withCompletion completion: @escaping (ModelType?) -> Void)
	func post(_ data: Data, withCompletion completion: @escaping (Result<HTTPURLResponse, APIError>) -> Void)
}

extension APINetworkRequest {
	
	func load(_ url: URL, withCompletion completion: @escaping (ModelType?) -> Void) {

		let task = URLSession.shared.dataTask(with: url) { [weak self] (data, response , error) -> Void in
			print("Load: \(url.absoluteString)")
			print("Data: \(String(decoding: data!, as: UTF8.self))")
			
			guard let data = data else {
				DispatchQueue.main.async { completion(nil) }
				return
			}
			do {
				let value = try self?.decode(data)
				DispatchQueue.main.async { completion(value) }
			} catch {
				print("Error")
			}
			
			
//			guard let data = data, let value = try? self?.decode(data) else {
//				DispatchQueue.main.async { completion(nil) }
//				return
//			}
//			DispatchQueue.main.async { completion(value) }
		}
		task.resume()
	}
	
	func post(_ url: URL, data: Data, withCompletion completion: @escaping (Result<HTTPURLResponse, APIError>) -> Void) {
		var request = URLRequest(url: url)
		request.httpMethod = "POST"
		
		let task = URLSession.shared.uploadTask(with: request, from: data) { (data, response , error) -> Void in
			
			DispatchQueue.main.async {
				if let error = error {
					completion(.failure(.URLSessionError))
					print(error.localizedDescription)
				}
				
				if let httpResponse = response as? HTTPURLResponse {
					switch httpResponse.statusCode {
						case 200..<300:
							completion(.success(httpResponse))
						default:
							print("Error: HTTP Status Code: \(httpResponse.statusCode)")
							completion(.failure(.PostError))
					}
				}
			}
			
		}
		task.resume()

	}
}
