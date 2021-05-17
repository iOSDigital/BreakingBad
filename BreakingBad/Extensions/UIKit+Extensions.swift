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
