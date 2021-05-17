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
		let sortOrder: OptionsSortOrder = (sender.selectedSegmentIndex == 0) ? .Default : .AtoZ
		self.delegate?.changeSortOrder(sortOrder)
	}
	
	@IBAction func layoutAction(_ sender: UISegmentedControl) {
		let layout: OptionsLayout = (sender.selectedSegmentIndex == 0) ? .Row : .Grid
		self.delegate?.changeLayout(layout)
	}
	
	@IBAction func refreshAction(_ sender: UIButton) {
		
	}


}




enum OptionsSortOrder {
	case AtoZ
	case Default
}
enum OptionsLayout {
	case Grid
	case Row
}

protocol CharactersOptionsControllerDelegate {
	func changeSortOrder(_ sortOrder: OptionsSortOrder)
	func changeLayout(_ layout: OptionsLayout)
}
