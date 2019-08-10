//
//  UIView+MP.swift
//  mpkit
//
//  Created by Martin Prot on 06/10/2017.
//  Copyright © 2017 Appricot media. All rights reserved.
//

import UIKit

extension TimeInterval {
	public static let quickAnimationDuration: TimeInterval = 0.2
	public static let standardAnimationDuration: TimeInterval = 0.4
	public static let slowAnimationDuration: TimeInterval = 0.8
}

extension CGFloat {
	public static let invisible: CGFloat = 0
	public static let opaque: CGFloat = 1
	public static let almostOpaque: CGFloat = 0.8
	
	public static let standardSpringDampingRatio: CGFloat = 0.7
	public static let standardSpringInitialVelocity: CGFloat = 0.2

}


extension UIView {
	
	/// Shows the view animated. Un-hide the view if isHidden is true
	///
	/// - Parameters:
	///   - duration: the animation duration
	///   - completion: callback on completion
	public func showAnimated(duration: TimeInterval = .standardAnimationDuration, delayed: TimeInterval = 0, completion: (() -> ())? = .none) {
		if self.isHidden {
			self.alpha = 0
			self.isHidden = false
		}
		UIView.animate(withDuration: duration, delay: delayed, options: [], animations: {
			self.alpha = 1
		}) { _ in
			completion?()
		}
	}
	
	/// Hides the view animated. View isHidden is set to true at animation end
	///
	/// - Parameters:
	///   - duration: the animation duration
	///   - completion: callback on completion
	public func hideAnimated(duration: TimeInterval = .standardAnimationDuration, delayed: TimeInterval = 0, completion: (() -> ())? = .none) {
		if self.isHidden { return }
		UIView.animate(withDuration: duration, delay: delayed, options: [], animations: {
			self.alpha = 0
		}) { _ in
			self.isHidden = true
			self.alpha = 1
			completion?()
		}
	}
	
	/// Adds the subview with a fade in animation with the given duration
	///
	/// - Parameters:
	///   - subview: the subview will be added to superview children
	///   - fadingInDuration: the fade animation duration
	public func addSubview(_ subview: UIView, fadingInDuration: TimeInterval) {
		subview.alpha = 0
		self.addSubview(subview)
		subview.showAnimated(duration: fadingInDuration, delayed: 0)
	}
	
	/// Fades the view out, then removes it from its superview
	///
	/// - Parameter withFadeOutDuration: the fade out animation duration
	public func removeFromSuperView(withFadeOutDuration: TimeInterval) {
		self.hideAnimated(duration: withFadeOutDuration, delayed: 0) {
			self.removeFromSuperview()
		}
	}
	
	
	/// Fades the view out, then do the given middleAction, then fade in back.
	///
	/// - Parameters:
	///   - totalDuration: the duration of both animations
	///   - middleAction: the action to do when the view is hidden
	public func fadeOutFadeIn(totalDuration: TimeInterval = .standardAnimationDuration, middleAction: @escaping () -> ()) {
		self.hideAnimated(duration: totalDuration/2) {
			middleAction()
			self.showAnimated(duration: totalDuration/2)
		}
	}
	
	/// Shake animation for UIViews
	///
	/// - Parameters:
	///   - duration: the total animation duration
	///   - count: the number of shakes
	///   - amplitude: the amount of pixel the animation shifts
	public func shake(during duration: TimeInterval = .standardAnimationDuration, count: Float = 4, amplitude: CGPoint = CGPoint(x: 10, y: 0)){
		let animation = CABasicAnimation(keyPath: "position")
		animation.duration = duration/Double(count)
		animation.repeatCount = count
		animation.autoreverses = true
		animation.fromValue = NSValue(cgPoint: CGPoint(x: self.center.x - amplitude.x, y: self.center.y - amplitude.y))
		animation.toValue = NSValue(cgPoint: CGPoint(x: self.center.x + amplitude.x, y: self.center.y + amplitude.y))
		self.layer.add(animation, forKey: "position")
	}
	
	public static func animateCurvy(duration: TimeInterval = .standardAnimationDuration, animations: @escaping () -> Void) {
		animate(withDuration: .standardAnimationDuration, delay: 0, options: .curveEaseInOut,
				animations: animations, completion: .none)
	}
	
	public static func animateCurvy(duration: TimeInterval = .standardAnimationDuration, animations: @escaping () -> Void, completion: ((Bool) -> Void)?) {
		animate(withDuration: .standardAnimationDuration, delay: 0, options: .curveEaseInOut, animations:
			animations, completion: completion)
	}
	
	public static func animateSpringly(duration: TimeInterval = .standardAnimationDuration, animations: @escaping () -> Void) {
		animate(withDuration: duration, delay: 0,
				usingSpringWithDamping: .standardSpringDampingRatio,
				initialSpringVelocity: .standardSpringInitialVelocity,
				options: .curveEaseInOut,
				animations: animations,
				completion: nil)
	}
	
	public static func animateSpringly(duration: TimeInterval = .standardAnimationDuration, animations: @escaping () -> Void, completion: ((Bool) -> Void)?) {
		animate(withDuration: duration, delay: 0,
				usingSpringWithDamping: .standardSpringDampingRatio,
				initialSpringVelocity: .standardSpringInitialVelocity,
				options: .curveEaseInOut,
				animations: animations,
				completion: completion)
	}
	
	public func layoutNow() {
		self.setNeedsLayout()
		self.layoutIfNeeded()
	}
	
	public func commitLayoutAnimated(duration: TimeInterval = .standardAnimationDuration) {
		UIView.animate(withDuration: duration) {
			self.layoutIfNeeded()
		}
	}
	
	public func makeRound() {
		self.layer.cornerRadius = min(self.bounds.width, self.bounds.height) / 2
		self.clipsToBounds = true
	}
	
	public func toFront() {
		guard let superview = self.superview else { return }
		superview.bringSubviewToFront(self)
	}
	
	public func toBack() {
		guard let superview = self.superview else { return }
		superview.sendSubviewToBack(self)
	}
}

extension UIView.AutoresizingMask {
    public static var centered: UIView.AutoresizingMask = [.flexibleTopMargin, .flexibleBottomMargin, .flexibleLeftMargin, .flexibleRightMargin]
    public static var flexibleSize: UIView.AutoresizingMask = [.flexibleWidth, .flexibleHeight]
	
	public static var topLeft: UIView.AutoresizingMask = [.flexibleBottomMargin, .flexibleRightMargin]
	public static var topRight: UIView.AutoresizingMask = [.flexibleBottomMargin, .flexibleLeftMargin]
	public static var bottomLeft: UIView.AutoresizingMask = [.flexibleTopMargin, .flexibleRightMargin]
	public static var bottomRight: UIView.AutoresizingMask = [.flexibleTopMargin, .flexibleLeftMargin]
}
