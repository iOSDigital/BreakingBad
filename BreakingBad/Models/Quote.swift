//
//  Quote.swift
//  BreakingBad
//
//  Created by Paul Derbyshire on 19/05/2021.
//
import Foundation

struct Quote: Identifiable {
	var id: Int
	var quote: String?
	var author: String?
	var series: String?
}

extension Quote: Codable {
	enum CodingKeys: String, CodingKey {
		case quote, author, series
		case id = "quote_id"
	}
}

struct QuotesResource: APIResource {
	typealias ModelType = Quote
	var path = "/quote"
	var queryItems: [URLQueryItem]?
}

class QuotesDataModel {
	var quotes: [Quote] = []
	var request: APIRequest<QuotesResource>?
	
	public func allQuotesFor(character: Character, completion: @escaping LoadQuotesCompletion) {
		var resource = QuotesResource()
		let queryString = character.name?.replacingOccurrences(of: " ", with: "+")
		resource.queryItems = [
			URLQueryItem(name: "author", value: queryString),
			URLQueryItem(name: "limit", value: "100"),
			URLQueryItem(name: "offset", value: "0")
		]
		
		let request = APIRequest(resource: resource)
		self.request = request
		request.execute { quotes in
			completion(quotes ?? [])
		}
		
	}
	typealias LoadQuotesCompletion = ((_ quotes: [Quote]) -> Void)
	
}
