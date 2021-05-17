//
//  UIKit+Extensions.swift
//  BreakingBad
//
//  Created by Paul Derbyshire on 17/05/2021.
//

import Foundation
import UIKit


extension UIBarButtonItem {
	var view: UIView? {
		return perform(#selector(getter: UIViewController.view)).takeRetainedValue() as? UIView
	}
}

extension UINavigationBar {
	open override func awakeFromNib() {
		super.awakeFromNib()
		let navBarAppearance = UINavigationBarAppearance()
		navBarAppearance.configureWithTransparentBackground()
		navBarAppearance.backgroundColor = .accentColor
		navBarAppearance.titleTextAttributes = [.foregroundColor: UIColor.white]
		navBarAppearance.largeTitleTextAttributes = [.foregroundColor: UIColor.white]
		self.standardAppearance = navBarAppearance
		self.scrollEdgeAppearance = navBarAppearance
	}
}

extension UIColor {
	static var accentColor: UIColor {
		if let color = UIColor(named: "AccentColor") {
			return color
		}
		return .darkGray
	}
}



