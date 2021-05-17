//
//  ViewController.swift
//  BreakingBad
//
//  Created by Paul Derbyshire on 17/05/2021.
//

import UIKit

class ViewController: UIViewController {
	let charactersModel = CharactersDataModel()

	override func viewDidLoad() {
		super.viewDidLoad()
	}
	
	override func viewDidAppear(_ animated: Bool) {
		super.viewDidAppear(animated)
		
		let chars = charactersModel.allCharacters { characters in
			print("Done")
		}
	}

}

