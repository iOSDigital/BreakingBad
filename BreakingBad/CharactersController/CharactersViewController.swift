//
//  CharactersViewController.swift
//  BreakingBad
//
//  Created by Paul Derbyshire on 17/05/2021.
//

import UIKit
import SDWebImage


class CharactersViewController: UICollectionViewController, CharactersOptionsControllerDelegate {
	
	
	let charactersModel = CharactersDataModel()
	var characters = [Character]()
	var characterOptionsPopover: CharactersOptionsController?
	var sortOrder: CharacterOptionsSortOrder = .Default
	
	
	// MARK: - Methods Body
	override func viewDidLoad() {
        super.viewDidLoad()
		collectionView.collectionViewLayout = compositionalLayout()
		characterOptionsPopover = self.storyboard?.instantiateViewController(identifier: "OptionsPopover") as? CharactersOptionsController
		characterOptionsPopover?.delegate = self
    }
	
	override func viewDidAppear(_ animated: Bool) {
		super.viewDidAppear(animated)
		loadData()
	}
	
	func loadData() {
		charactersModel.allCharacters { characters in
			self.characters = characters
			self.sortData()
			self.collectionView.reloadSections(IndexSet(0...0))
		}
		
	}
	
	func sortData() {
		self.characters.sort { c1, c2 in
			var isSorted = false
			
			if self.sortOrder == .AtoZ {
				if let first = c1.name, let second = c2.name {
					isSorted = first < second
				}
			} else if self.sortOrder == .Default {
				isSorted = c1.id < c2.id
			}
			return isSorted
		}
		self.collectionView.reloadSections(IndexSet(0...0))
	}
	
	@IBAction func optionsButtonAction(_ sender: UIBarButtonItem) {
		guard let popover = characterOptionsPopover else { return }
		showPopup(popover, sourceView: sender.view!)
	}
	
		
	private func showPopup(_ controller: UIViewController, sourceView: UIView) {
		let presentationController = AlwaysPresentAsPopover.configurePresentation(forController: controller)
		presentationController.sourceView = sourceView
		presentationController.sourceRect = sourceView.bounds
		presentationController.permittedArrowDirections = [.down, .up]
		self.present(controller, animated: true)
	}

	

	// MARK: - UICollectionViewDataSource

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

    // MARK: - UICollectionViewDelegate
	// The grid layout for the collectionView
	func compositionalLayout(fraction: CGFloat = 1/2) -> UICollectionViewCompositionalLayout {
		let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(fraction), heightDimension: .fractionalHeight(1))
		let item = NSCollectionLayoutItem(layoutSize: itemSize)
		let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalWidth(fraction))
		let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
		let section = NSCollectionLayoutSection(group: group)
		return UICollectionViewCompositionalLayout(section: section)
	}
	
	override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
		let character = characters[indexPath.row]
		let detailController = self.storyboard?.instantiateViewController(identifier: "CharactersDetailViewController") as! CharactersDetailViewController
		detailController.modalPresentationStyle = .automatic
		self.present(detailController, animated: true)
		detailController.character = character
	}
	
	
	// MARK: - CharactersOptionsControllerDelegate
	func changeSortOrder(_ sortOrder: CharacterOptionsSortOrder, sender: CharactersOptionsController) {
		self.sortOrder = sortOrder
		self.sortData()
	}
	
	func changeLayout(_ layout: CharacterOptionsLayout, sender: CharactersOptionsController) {
		var fraction: CGFloat = 1/1
		switch layout {
			case .Grid:
				fraction = 1/2
			case .Row:
				fraction = 1/1
		}
		collectionView.collectionViewLayout = compositionalLayout(fraction: fraction)
		self.collectionView.reloadSections(IndexSet(0...0))
	}

	func refreshCharacters(_ sender: CharactersOptionsController) {
		//TODO
	}

	
	
}


