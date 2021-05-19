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

extension Date {
	func apiStringFromDate() -> String {
		let formatter = DateFormatter()
		formatter.dateFormat = "yyyy-MM-dd"
		return formatter.string(from: self)
	}
}

extension FileManager {
	class func getDocumentsDirectoryURL() -> URL {
		let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
		let documentsDirectory = paths[0]
		return documentsDirectory
	}
}
