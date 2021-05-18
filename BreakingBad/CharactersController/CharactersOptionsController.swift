//
//  CharactersOptionsController.swift
//  BreakingBad
//
//  Created by Paul Derbyshire on 17/05/2021.
//

import UIKit


class CharactersOptionsController: UITableViewController {
	
	var delegate: CharactersOptionsControllerDelegate?
	
    override func viewDidLoad() {
        super.viewDidLoad()
    }
	
	@IBAction func sortOrderAction(_ sender: UISegmentedControl) {
		let sortOrder: CharacterOptionsSortOrder = (sender.selectedSegmentIndex == 0) ? .Default : .Alphabetical
		self.delegate?.changeSortOrder(sortOrder, sender: self)
	}
	
	@IBAction func layoutAction(_ sender: UISegmentedControl) {
		let layout: CharacterOptionsLayout = (sender.selectedSegmentIndex == 0) ? .Row : .Grid
		self.delegate?.changeLayout(layout, sender: self)
	}
	
	@IBAction func refreshAction(_ sender: UIButton) {
		
	}

}

protocol CharactersOptionsControllerDelegate: AnyObject {
	func changeSortOrder(_ sortOrder: CharacterOptionsSortOrder, sender: CharactersOptionsController)
	func changeLayout(_ layout: CharacterOptionsLayout, sender: CharactersOptionsController)
	func refreshCharacters(_ sender: CharactersOptionsController)
}
