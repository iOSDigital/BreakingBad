//
//  Quote.swift
//  BreakingBad
//
//  Created by Paul Derbyshire on 19/05/2021.
//
import Foundation

struct Quote: Identifiable {
	var id: String
	var quote: String?
	var author: String?
}

extension Quote: Codable {
	enum CodingKeys: String, CodingKey {
		case quote, author
		case id = "quote_id"
	}
}

struct QuotesResource: APIResource {
	typealias ModelType = Quote
	var path = "/quote"
	var queryItems: [URLQueryItem]?
}

class QuotesDataModel {
	var reviews: [Review] = []
	var request: APIRequest<QuotesResource>?
	
	public func allQuotesForCharacter(_ character: Character, completion: @escaping LoadQuotesCompletion) {
		var resource = QuotesResource()
		var queryString = character.name?.replacingOccurrences(of: " ", with: "+")
		resource.queryItems = [
			URLQueryItem(name: "author", value: queryString)
		]
		
		let request = APIRequest(resource: resource)
		self.request = request
		request.execute { reviews in
			completion(reviews ?? [])
		}
		
	}
	typealias LoadQuotesCompletion = ((_ quotes: [Quote]) -> Void)
	
}
