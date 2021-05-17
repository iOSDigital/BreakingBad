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
	
	override func awakeFromNib() {
		super.awakeFromNib()
		self.imageView.layer.cornerRadius = 10.0
		self.imageView.layer.borderWidth = 1.0
		self.imageView.layer.borderColor = UIColor.white.cgColor
	}
	
}
