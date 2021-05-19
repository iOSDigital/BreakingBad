//
//  CharactersDetailViewController.swift
//  BreakingBad
//
//  Created by Paul Derbyshire on 17/05/2021.
//

import UIKit

class CharactersDetailViewController: UITableViewController {
	var character: Character!
	
	@IBOutlet var reviewName: UITextField!
	@IBOutlet var reviewDate: UITextField!
	@IBOutlet var reviewTextView: UITextView!
	@IBOutlet var imageView: UIImageView!
	@IBOutlet var nameLabel: UILabel!
	@IBOutlet var occupationLabel: UILabel!
	@IBOutlet var dobLabel: UILabel!
	@IBOutlet var nicknameLabel: UILabel!
	@IBOutlet var statusLabel: UILabel!
	@IBOutlet var portrayedLabel: UILabel!
	@IBOutlet var appearsInLabel: UILabel!
	@IBOutlet var likeButton: UIButton!
	let likeButtonOffImage = UIImage(systemName: "heart")
	let likeButtonOnImage = UIImage(systemName: "heart.fill")
	#warning("Hacky cell height thing")
	var cellHeights = [350, 40, 40, 40, 40, 40, 40, 40, 0, 40, 0]
	
	public class func controllerWithCharacter(   character: Character) -> CharactersDetailViewController {
		let controller = UIStoryboard(name: "Characters", bundle: nil).instantiateViewController(identifier: "CharactersDetailViewController") as! CharactersDetailViewController
		controller.character = character
		return controller
	}
	
	override func viewDidLoad() {
		super.viewDidLoad()
		commonInit()
	}
	
	private func commonInit() {
		if UserDefaults.isFavourite(character.id) {
			likeButton.setImage(likeButtonOnImage, for: .normal)
		}
		imageView.sd_setImage(with: character.imageURL)
		nameLabel.text = character.name
		occupationLabel.text = character.occupation?.joined(separator: " / ")
		dobLabel.text = character.birthday
		nicknameLabel.text = character.nickname
		statusLabel.text = character.status
		portrayedLabel.text = character.portrayed
		if let series = character.appearance?.map({String($0) }).joined(separator: ", "), !series.isEmpty {
			appearsInLabel.text = "Series \(series)"
		}
		
		reviewTextView.layer.borderColor = UIColor.systemGray4.cgColor
		reviewTextView.layer.borderWidth = 1.0
		reviewTextView.layer.cornerRadius = 4
		
		tableView.rowHeight = UITableView.automaticDimension
		tableView.estimatedRowHeight = 40
		
	}
	
	
	@IBAction func likeButtonAction(_ sender: UIButton) {
		UserDefaults.toggleFavourite(character.id)
		if UserDefaults.isFavourite(character.id) {
			sender.setImage(likeButtonOnImage, for: .normal)
		} else {
			sender.setImage(likeButtonOffImage, for: .normal)
		}
	}
	
	@IBAction func postReviewAction(_ sender: UIButton) {
		if let name = reviewName.text, let date = reviewDate.text, let reviewBody = reviewTextView.text {
			let review = Review(id: UUID().uuidString, characterID: character.id, name: name, watchDate: date, reviewBody: reviewBody)
			
			ReviewsDataModel().postReview(review: review) { result in
				switch result {
					case .success(let response):
						print("SUCCESS")
					case .failure(let error):
						print(error.localizedDescription)
						let alert = UIAlertController.simpleErrorAlert(title: "Sorry, an error has occured", body: "Your review was unable to be posted.")
						self.present(alert, animated: true, completion: nil)
				}
			}
		}
	}
	
	
	//MARK: - TableView Delegate
	override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
		let cgHeight = CGFloat(cellHeights[indexPath.row])
		return cgHeight
	}
	
	#warning("Layout constraint errors")
	@IBAction func quotesButtonAction(_ sender: UIButton) {
		if cellHeights[8] == 0 {
			cellHeights[8] = 100
		} else {
			cellHeights[8] = 0
		}
		self.tableView.beginUpdates()
		self.tableView.reloadData()
		self.tableView.endUpdates()
	}
	@IBAction func reviewButtonAction(_ sender: UIButton) {
		if cellHeights[10] == 0 {
			cellHeights[10] = 240
		} else {
			cellHeights[10] = 0
		}
		self.tableView.beginUpdates()
		self.tableView.reloadData()
		self.tableView.endUpdates()
	}
	
	@IBAction func dismissController() {
		self.dismiss(animated: true) {
		}
	}
	
}
