//
//  CharactersDetailViewController.swift
//  BreakingBad
//
//  Created by Paul Derbyshire on 17/05/2021.
//

import UIKit

class CharactersDetailViewController: UITableViewController {
	
	var character: Character!
	let quotesDataModel = QuotesDataModel()
	
	@IBOutlet var quoteLabel: UILabel!
	@IBOutlet var reviewName: UITextField!
	@IBOutlet var reviewDate: UIDatePicker!
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
	
	
	//MARK: - Method Body

	public class func controllerWithCharacter(character: Character) -> CharactersDetailViewController {
		let controller = UIStoryboard(name: "Characters", bundle: nil).instantiateViewController(identifier: "CharactersDetailViewController") as! CharactersDetailViewController
		controller.character = character
		return controller
	}
	
	override func viewDidLoad() {
		super.viewDidLoad()
		commonInit()
	}
	
	override func viewDidAppear(_ animated: Bool) {
		super.viewDidAppear(animated)
		loadQuotes()
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
	
	
	//MARK: - Actions
	@IBAction func likeButtonAction(_ sender: UIButton) {
		UserDefaults.toggleFavourite(character.id)
		if UserDefaults.isFavourite(character.id) {
			sender.setImage(likeButtonOnImage, for: .normal)
		} else {
			sender.setImage(likeButtonOffImage, for: .normal)
		}
	}
	
	@IBAction func datePickerAction(_ sender: UIDatePicker) {
		self.dismiss(animated: true, completion: nil)
	}
	
	func loadQuotes() {
		if character.quotes != nil { self.newQuote(nil); return }
		quotesDataModel.allQuotesFor(character: character) { quotes in
			self.character.quotes = quotes
			self.newQuote(nil)
		}
	}
	@IBAction func newQuote(_ sender: AnyObject?) {
		self.quoteLabel.text = character.quotes?.shuffled().first?.quote
	}
	
	@IBAction func postReviewAction(_ sender: UIButton) {

		if let name = reviewName.text, let reviewBody = reviewTextView.text,
		   !name.isEmpty, !reviewBody.isEmpty {
			let date = reviewDate.date.apiStringFromDate()
			let review = Review(id: UUID().uuidString, characterID: character.id, name: name, watchDate: date, reviewBody: reviewBody)

			ReviewsDataModel().postReview(review: review) { result in
				switch result {
					case .success(let response):
						// Hide the fields?
						print("SUCCESS: \(response.statusCode)")
					case .failure(let error):
						print(error.localizedDescription)
						let alert = UIAlertController.simpleErrorAlert(title: "Sorry, an error has occured", body: "Your review was unable to be posted.")
						self.present(alert, animated: true, completion: nil)
				}
			}
		} else {
			let alert = UIAlertController.simpleErrorAlert(title: "Error", body: "Please make sure all fields are filled in")
			self.present(alert, animated: true, completion: nil)
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
			if character.quotes?.count ?? 0 > 0 {
				cellHeights[8] = 100
			}
		} else {
			cellHeights[8] = 0
		}
		self.tableView.beginUpdates()
		self.tableView.reloadData()
		self.tableView.endUpdates()
	}
	@IBAction func reviewButtonAction(_ sender: UIButton?) {
		if cellHeights[10] == 0 {
			cellHeights[10] = 240
			self.reviewName.perform(#selector(becomeFirstResponder), with: nil, afterDelay: 0.1)
		} else {
			cellHeights[10] = 0
			self.resignFirstResponder()
		}
		self.tableView.beginUpdates()
		self.tableView.reloadData()
		self.tableView.endUpdates()
		self.tableView.scrollToRow(at: IndexPath(row: 10, section: 0), at: .bottom, animated: true)
	}
	override var canResignFirstResponder: Bool {
		return true
	}
	
	@IBAction func dismissController() {
		self.dismiss(animated: true) {
		}
	}
	
}
