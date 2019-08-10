//
//  MPChoiceListsViewController.swift
//  mpkit
//
//  Created by Martin Prot on 10/01/2019.
//  Copyright © 2019 appricot. All rights reserved.
//

import UIKit

public struct ChoiceList {
	public let title: String?
	public let message: String?
	public let choices: [Choice]
	
	public init(title: String? = nil, message: String? = nil, choices: [Choice]) {
		self.title = title
		self.message = message
		self.choices = choices
	}
}

public protocol Choice {
	var choiceName: String { get }
}

/// A navigation controller that let user to choose among a list of different choices, with succession of choice controllers
/// Choice types can be different kind, but each choice should implement the Choice protocol
/// TODO: add better iPhone support (size correctly in popover)
///		  add the back navigation
/// 	  add title, message and cell customisation
/// 	  add a pager
public class MPChoiceListsViewController: UINavigationController {
	
	private var choiceLists: [ChoiceList]
	private var selected: [Choice] = []
	public var didSelect: (([Choice]) -> ())?
	
	public init(choiceLists: [ChoiceList]) {
		self.choiceLists = choiceLists
		super.init(nibName: nil, bundle: nil)
		self.isNavigationBarHidden = true
		// note: to add the back functionnality, choiceLists property should be non mutable, a currentIndex should be added
		// and the back action should be detected with UINavigationControllerDelegate
	}
	
	required init?(coder aDecoder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
	public override func viewDidLoad() {
		super.viewDidLoad()
		
		if choiceLists.count == 0 {
			fatalError("UIChoiceListsViewController did load without any choice!")
		}
		let first = choiceLists.remove(at: 0)
		self.pushOptionsViewController(for: first, animated: false)
	}
	
	private func pushOptionsViewController(for choiceList: ChoiceList, animated: Bool) {
		let options = choiceList.choices.map { choice in
			return MPChoicesViewController.Option(title: choice.choiceName, handler: { [weak self] in
				guard let self = self else { return }
				print("selected \(choice.choiceName)")
				self.selected.append(choice)
				if self.choiceLists.count > 0 {
					let first = self.choiceLists.remove(at: 0)
					self.pushOptionsViewController(for: first, animated: true)
				}
				else {
					self.didSelect?(self.selected)
					self.popOrDismiss(animated: true)
				}
			})
		}
		let optionsController = MPChoicesViewController(title: choiceList.title, message: choiceList.message, options: options)
		if animated, let controller = self.viewControllers.first {
			controller.view.hideAnimated()
			// ... for ipad popover, since controller views wont have a background color, when pushed the new
			// controllers view content will be over the old one during the transition
		}
		self.pushViewController(optionsController, animated: true) {
			self.preferredContentSize = CGSize(width: 0, height: optionsController.preferredHeight)
		}
	}
}
