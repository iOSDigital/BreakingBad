//
//  CharactersDetailViewController.swift
//  BreakingBad
//
//  Created by Paul Derbyshire on 17/05/2021.
//

import UIKit

class CharactersDetailViewController: UITableViewController {
	
	@IBOutlet var imageView: UIImageView!
	@IBOutlet var nameLabel: UILabel!
	@IBOutlet var occupationLabel: UILabel!
	@IBOutlet var dobLabel: UILabel!
	@IBOutlet var nicknameLabel: UILabel!
	@IBOutlet var statusLabel: UILabel!
	@IBOutlet var portrayedLabel: UILabel!
	@IBOutlet var appearsInLabel: UILabel!

	
	var character: Character? {
		didSet {
			imageView.sd_setImage(with: character?.imageURL)
			nameLabel.text = character?.name
			occupationLabel.text = character?.occupation?.joined(separator: " / ")
			dobLabel.text = character?.birthday
			nicknameLabel.text = character?.nickname
			statusLabel.text = character?.status
			portrayedLabel.text = character?.portrayed
			appearsInLabel.text = character?.appearance?.map{ "Series " + String($0) }.joined(separator: "\n")
		}
	}
	
	override func viewDidLoad() {
		super.viewDidLoad()
		tableView.rowHeight = UITableView.automaticDimension
		tableView.estimatedRowHeight = 40
	}
	
}
