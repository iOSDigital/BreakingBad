//
//  Character.swift
//  BreakingBad
//
//  Created by Paul Derbyshire on 17/05/2021.
//

import Foundation

struct Character: Decodable {
	var id: Int
	var name: String
	var birthday: String
	var occupation: [String]
	var img: String
	var status: String
	var nickname: String
	var appearance: [Int]
	var portrayed: String
	var category: [String]
}
