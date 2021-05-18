//
//  UserDefaults+Extenstions.swift
//  BreakingBad
//
//  Created by Paul Derbyshire on 18/05/2021.
//

import Foundation

enum UserDefaultsKeys: String {
	case favouritesArrayName = "favouritesArrayName"
	case lastSyncTime = "lastSyncTime"
}

extension UserDefaults {
	
	class func isFavourite(_ characterID: Int) -> Bool {
		if let userFavouritesArray = UserDefaults.standard.array(forKey: UserDefaultsKeys.favouritesArrayName.rawValue) as? [Int] {
			return userFavouritesArray.contains(characterID)
		}
		return false
	}
	
	class func toggleFavourite(_ characterID: Int) {
		var favouritesArray = [Int]()
		if let userFavouritesArray = UserDefaults.standard.array(forKey: UserDefaultsKeys.favouritesArrayName.rawValue) as? [Int] {
			favouritesArray = userFavouritesArray
			if favouritesArray.contains(characterID) {
				favouritesArray.removeObject(object: characterID)
			} else {
				favouritesArray.append(characterID)
			}
		} else {
			favouritesArray = [characterID]
		}
		UserDefaults.standard.setValue(favouritesArray, forKey: UserDefaultsKeys.favouritesArrayName.rawValue)
	}
	
	class func lastSyncTime() -> Date? {
		let date = UserDefaults.standard.object(forKey: UserDefaultsKeys.lastSyncTime.rawValue) as! Date
		return date
	}
	
}


