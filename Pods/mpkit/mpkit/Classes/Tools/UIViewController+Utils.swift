//
//  UIViewController+Utils.swift
//  mpkit
//
//  Created by Martin Prot on 12/03/2018.
//  Copyright © 2017 Appricot media. All rights reserved.
//

import UIKit

extension UIViewController {
	
	/// returns the current view controller embedded into a newly created navigation controller
	public func intoNavigation(hiddenNavBar: Bool = false) -> UINavigationController {
		let nav = UINavigationController(rootViewController: self)
		nav.isNavigationBarHidden = hiddenNavBar
		return nav
	}
	
	/**
	*  Present an alert describing the error, with an optional title
	*
	*/
	public func present(error: Error?, title: String? = nil, message: String? = nil, onRetry:(() -> Void)? = nil, onCancel:(() -> Void)? = nil) {
		let ac = UIAlertController(title: title, message: message ?? error?.localizedDescription, preferredStyle: .alert)
		ac.addAction(UIAlertAction(title: "Ok".localized, style: .cancel, handler: { _ in
			onCancel?()
		}))
		if let onRetry = onRetry {
			ac.addAction(UIAlertAction(title: "Retry".localized, style: .default, handler: { _ in
				onRetry()
			}))
		}
		present(ac, animated: true, completion: nil)
	}
	
	/**
	*  Present an simple confirm alert
	*
	*/
	public func confirm(title: String? = nil, message: String? = nil, onConfirm: @escaping () -> Void) {
		let ac = UIAlertController(title: title, message: message, preferredStyle: .alert)
		ac.addAction(UIAlertAction(title: "Cancel".localized, style: .cancel, handler: nil))
		ac.addAction(UIAlertAction(title: "Confirm".localized, style: .default, handler: { _ in
			onConfirm()
		}))
		present(ac, animated: true, completion: nil)
	}
	
	
	/// Presents a full screen loader that prevents all on-screen interaction (nav bars are not impacted)
	///
	/// - Parameters:
	///   - style: the loader style
	///   - blackAlpha: the opacity of the black background
	public func presentLoaderController(style: UIActivityIndicatorView.Style = .whiteLarge, blackAlpha: CGFloat = 0.8) -> UIViewController {
		let controller = UIViewController()
		let loader = UIActivityIndicatorView(style: style)
		loader.autoresizingMask = .centered
		loader.center = CGPoint(controller.view.bounds.size / 2)
		loader.startAnimating()
		controller.view.backgroundColor = .init(white: 0, alpha: blackAlpha)
		controller.view.addSubview(loader)
		controller.modalPresentationStyle = .overCurrentContext
		controller.modalTransitionStyle = .crossDissolve
		self.present(controller, animated: true, completion: nil)
		return controller
	}
	
	/**
	*  Tells if the view controller can be popped
	*
	*/
	public var canPopViewController: Bool {
		if let nav = self.navigationController, self != nav.viewControllers.first {
			return true
		}
		else {
			return false
		}
	}
	
	/**
	*  Pop current view controller if there is a navigation controller, and if current is not the first controller
	*  otherwise, dismiss
	*/
	public func popOrDismiss(animated: Bool) {
		if self.canPopViewController {
			self.navigationController?.popViewController(animated: true)
		}
		else {
			self.dismiss(animated: true, completion: nil)
		}
	}
	
	/// The view controller presented by the vc presented of the vc presented of ... of this view controller
	public var topPresentedController: UIViewController {
		guard let controller = self.presentedViewController else { return self }
		return controller.topPresentedController
	}
}

// Swift 3 version, no co-animation (alongsideTransition parameter is nil)
extension UINavigationController {
	
	public func pushViewController(_ viewController: UIViewController, animated: Bool, completion: @escaping () -> Void) {
		self.pushViewController(viewController, animated: animated)
		guard animated, let coordinator = transitionCoordinator else {
			completion()
			return
		}
		coordinator.animate(alongsideTransition: nil) { _ in completion() }
	}
	
	public func setViewControllers(_ viewControllers: [UIViewController], animated: Bool, completion: @escaping () -> Void) {
		self.setViewControllers(viewControllers, animated: animated)
		guard animated, let coordinator = transitionCoordinator else {
			completion()
			return
		}
		coordinator.animate(alongsideTransition: nil) { _ in completion() }
	}
}
