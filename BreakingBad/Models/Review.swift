//
//  Review.swift
//  BreakingBad
//
//  Created by Paul Derbyshire on 17/05/2021.
//

import Foundation

struct Review: Identifiable {
	var id: String
	var characterID: Int
	var name: String?
	var watchDate: String?
	var reviewBody: String?
}

extension Review: Codable {
	enum CodingKeys: String, CodingKey {
		case id, characterID, name, watchDate, reviewBody
	}
}

struct ReviewsResource: APIResource {
	typealias ModelType = Review
	var path = "/reviews"
	var method = "POST"
}

class ReviewsDataModel {
	var characters: [Review] = []
	var request: APIRequest<ReviewsResource>?
	
	public func postReview(review: Review, completion: @escaping PostReviewCompletion) {
		let resource = ReviewsResource()
		let request = APIRequest(resource: resource)
		self.request = request
		
		do {
			let jsonEncoder = JSONEncoder()
			let jsonData = try jsonEncoder.encode(review)
			request.post(jsonData) { (result) in
				completion(result)
			}

		} catch {
			print(error.localizedDescription)
		}
		print("postReview!")
	}
	typealias PostReviewCompletion = ((_ result: Result<HTTPURLResponse, APIError>) -> Void)
	
}


