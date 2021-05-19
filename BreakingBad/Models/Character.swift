//
//  Character.swift
//  BreakingBad
//
//  Created by Paul Derbyshire on 17/05/2021.
//

import Foundation

class Character: Codable, Identifiable {
	var id: Int
	var name: String?
	#warning("TODO: Make birthday a Date not String")
	var birthday: String?
	var occupation: [String]?
	var image: String?
	var status: String?
	var nickname: String?
	var appearance: [Int]?
	var portrayed: String?
	var category: String?
	var betterCallSaulAppearance: [Int]?
	var isFavourite: Bool = false
	var quotes: [Quote]?
}

extension Character {
	enum CodingKeys: String, CodingKey {
		case id = "char_id"
		case image = "img"
		case betterCallSaulAppearance = "better_call_saul_appearance"
		case name, birthday, occupation, status, nickname, appearance, portrayed, category
	}
	
	var imageURL: URL? {
		if let cImage = self.image {
			let imageURL = URL(string: cImage)
			return imageURL
		}
		return nil
	}
}

extension Character: Equatable {
	static func == (lhs: Character, rhs: Character) -> Bool {
		return lhs.id == rhs.id
	}
}

struct CharactersResource: APIResource {
	var modelName = "Character"
	typealias ModelType = Character
	var path = "/characters"
	var queryItems: [URLQueryItem]?
}

class CharactersDataModel {
	var characters: [Character] = []
	var request: APIRequest<CharactersResource>?
	
	public func allCharacters(completion: @escaping AllCharactersCompletion) {
		var resource = CharactersResource()
		resource.queryItems = [
			URLQueryItem(name: "limit", value: "100"),
			URLQueryItem(name: "offset", value: "0")
		]

		let request = APIRequest(resource: resource)
		self.request = request
		request.execute { characters in
			completion(characters ?? [])
		}
	}
	typealias AllCharactersCompletion = ((_ characters: [Character]) -> Void)
}

enum CharacterOptionsSortOrder {
	case Alphabetical
	case Default
	case Liked
}
enum CharacterOptionsLayout {
	case Grid
	case Row
}
