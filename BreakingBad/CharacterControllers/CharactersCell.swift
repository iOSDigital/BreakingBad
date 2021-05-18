//
//  CharactersCell.swift
//  BreakingBad
//
//  Created by Paul Derbyshire on 17/05/2021.
//

import UIKit

class CharactersCell: UICollectionViewCell {
	@IBOutlet var imageView: UIImageView!
	@IBOutlet var nameLabel: UILabel!
	@IBOutlet var likeButton: UIButton!
	
	var character: Character? {
		didSet {
			self.nameLabel.text = character?.name
			
			if let cImage = character?.image {
				let imageURL = URL(string: cImage)
				self.imageView.sd_setImage(with: imageURL) { image, error, cacheType, url in
					self.imageView.contentMode = .scaleAspectFill
				}
			}
			
			if let cID = character?.id {
				likeButton.isHidden = !UserDefaults.isFavourite(cID)
			}
			
		}
	}
	
}
