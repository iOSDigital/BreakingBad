//
//  CharactersSearchController.swift
//  BreakingBad
//
//  Created by Paul Derbyshire on 18/05/2021.
//

import UIKit

class CharactersSearchController: UIViewController, UISearchBarDelegate {
	
	@IBOutlet var searchBar: UISearchBar!
	weak var delegate: CharactersSearchDelegate?
	
	override func viewDidAppear(_ animated: Bool) {
		super.viewDidAppear(animated)
		searchBar.becomeFirstResponder()
	}
	
	func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
		self.delegate?.searchTextDidChange(searchText: searchText)
	}
	
}

protocol CharactersSearchDelegate: AnyObject {
	func searchTextDidChange(searchText: String)
}
