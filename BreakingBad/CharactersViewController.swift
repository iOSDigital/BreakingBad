//
//  CharactersViewController.swift
//  BreakingBad
//
//  Created by Paul Derbyshire on 17/05/2021.
//

import UIKit
import SDWebImage


class CharactersViewController: UICollectionViewController {
	
	let charactersModel = CharactersDataModel()
	var characters = [Character]()
	
	
	override func viewDidLoad() {
        super.viewDidLoad()
    }
	
	override func viewDidAppear(_ animated: Bool) {
		super.viewDidAppear(animated)
		charactersModel.allCharacters { characters in
			self.characters = characters
			self.collectionView.reloadSections(IndexSet(0...0))
		}
	}

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using [segue destinationViewController].
        // Pass the selected object to the new view controller.
    }
    */

    // MARK: UICollectionViewDataSource

    override func numberOfSections(in collectionView: UICollectionView) -> Int {
		return 1
    }


    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
		return characters.count
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
		let cellID = "CellCharacter"
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellID, for: indexPath) as! CharactersCell
		let character = characters[indexPath.row]
		cell.character = character
		
        return cell
    }

    // MARK: UICollectionViewDelegate

    /*
    // Uncomment this method to specify if the specified item should be highlighted during tracking
    override func collectionView(_ collectionView: UICollectionView, shouldHighlightItemAt indexPath: IndexPath) -> Bool {
        return true
    }
    */

    /*
    // Uncomment this method to specify if the specified item should be selected
    override func collectionView(_ collectionView: UICollectionView, shouldSelectItemAt indexPath: IndexPath) -> Bool {
        return true
    }
    */

    /*
    // Uncomment these methods to specify if an action menu should be displayed for the specified item, and react to actions performed on the item
    override func collectionView(_ collectionView: UICollectionView, shouldShowMenuForItemAt indexPath: IndexPath) -> Bool {
        return false
    }

    override func collectionView(_ collectionView: UICollectionView, canPerformAction action: Selector, forItemAt indexPath: IndexPath, withSender sender: Any?) -> Bool {
        return false
    }

    override func collectionView(_ collectionView: UICollectionView, performAction action: Selector, forItemAt indexPath: IndexPath, withSender sender: Any?) {
    
    }
    */

}


class CharactersCell: UICollectionViewCell {
	@IBOutlet var imageView: UIImageView!
	@IBOutlet var nameLabel: UILabel!
	
	var character: Character? {
		didSet {
			self.nameLabel.text = character?.name
			
			if let cImage = character?.image {
				let imageURL = URL(string: cImage)
				self.imageView.sd_setImage(with: imageURL) { image, error, cacheType, url in
					self.imageView.contentMode = .scaleAspectFill
				}
			}
		
		}
	}

	
}
