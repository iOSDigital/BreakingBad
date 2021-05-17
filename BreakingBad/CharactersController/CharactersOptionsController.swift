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
		let sortOrder: CharacterOptionsSortOrder = (sender.selectedSegmentIndex == 0) ? .Default : .AtoZ
		self.delegate?.changeSortOrder(sortOrder)
	}
	
	@IBAction func layoutAction(_ sender: UISegmentedControl) {
		let layout: CharacterOptionsLayout = (sender.selectedSegmentIndex == 0) ? .Row : .Grid
		self.delegate?.changeLayout(layout)
	}
	
	@IBAction func refreshAction(_ sender: UIButton) {
		
	}


}




enum CharacterOptionsSortOrder {
	case AtoZ
	case Default
}
enum CharacterOptionsLayout {
	case Grid
	case Row
}

protocol CharactersOptionsControllerDelegate {
	func changeSortOrder(_ sortOrder: CharacterOptionsSortOrder)
	func changeLayout(_ layout: CharacterOptionsLayout)
}
