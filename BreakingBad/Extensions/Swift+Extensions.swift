//
//  Swift+Extensions.swift
//  BreakingBad
//
//  Created by Paul Derbyshire on 18/05/2021.
//

import Foundation

extension Array where Element: Equatable {
	mutating func removeObject(object: Element)  {
		if let index = firstIndex(of: object) {
			remove(at: index)
		}
	}
}
