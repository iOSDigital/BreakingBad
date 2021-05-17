//
//  Character.swift
//  BreakingBad
//
//  Created by Paul Derbyshire on 17/05/2021.
//

import Foundation

struct Character: Identifiable {
	var id: Int
	var name: String?
	#warning("Make birthday a Date not String")
	var birthday: String?
	var occupation: [String]?
	var image: String?
	var status: String?
	var nickname: String?
	var appearance: [Int]?
	var portrayed: String?
	var category: String?
	var betterCallSaulAppearance: [Int]?
}

extension Character: Codable {
	enum CodingKeys: String, CodingKey {
		case id = "char_id"
		case image = "img"
		case betterCallSaulAppearance = "better_call_saul_appearance"
		case name, birthday, occupation, status, nickname, appearance, portrayed, category
	}
}

struct CharactersResource: APIResource {
	typealias ModelType = Character
	var path = "/characters"
}


class CharactersDataModel {
	var characters: [Character] = []
	var request: APIRequest<CharactersResource>?
	
	public func allCharacters(completion: @escaping AllCharactersCompletion) {
		let resource = CharactersResource()
		let request = APIRequest(resource: resource)
		self.request = request
		request.execute { characters in
			completion(characters ?? [])
//			self.characters = characters ?? []
		}
	}
	typealias AllCharactersCompletion = ((_ characters: [Character]) -> Void)
}
