//
//  UILoadingButton.swift
//  AnimatedCollectionViewLayout
//
//  Created by Martin Prot on 12/04/2018.
//

import UIKit

fileprivate extension CGFloat {
	static let disabledAlpha: CGFloat = 0.7
	static let highlightedBackgroundAlpha: CGFloat = 0.5
}

open class UILoadingButton: UIButton {
	
	public var isLoading: Bool = false
	
	public var loadingStyle: UIActivityIndicatorView.Style = .white
	
	override open var isEnabled: Bool {
		didSet {
			self.alpha = self.isEnabled ? 1 : .disabledAlpha
		}
	}
	
	@IBInspectable public var cornerRadius: CGFloat = 0
	
	private var buttonTitle: String?
	private var buttonImage: UIImage?
	private lazy var loader: UIActivityIndicatorView = {
		let activity = UIActivityIndicatorView(style: self.loadingStyle)
		activity.autoresizingMask = [.flexibleTopMargin, .flexibleLeftMargin, .flexibleRightMargin, .flexibleBottomMargin]
		activity.hidesWhenStopped = true
		activity.tintColor = self.titleColor(for: .normal)
		self.addSubview(activity)
		return activity
	}()
	
	override open func awakeFromNib() {
		super.awakeFromNib()
		self.layer.cornerRadius = cornerRadius
		self.clipsToBounds = true
		self.alpha = self.isEnabled ? 1 : 0.5
	}
	
	public func startLoading() {
		if !self.isLoading {
			self.loader.center = CGPoint(x: self.bounds.width/2, y: self.bounds.height/2)
			self.loader.startAnimating()
			self.buttonTitle = self.title(for: .normal)
			self.buttonImage = self.image(for: .normal)
			self.setTitle(.none, for: .normal)
			self.setImage(.none, for: .normal)
			self.isLoading = true
			self.isEnabled = false
			
		}
	}
	
	override open func setImage(_ image: UIImage?, for state: UIControl.State) {
		if self.isLoading, state == .normal {
			self.buttonImage = image
		}
		else {
			super.setImage(image, for: state)
		}
	}
	
	public func stopLoading() {
		if self.isLoading {
			self.isEnabled = true
			self.isLoading = false
			self.loader.stopAnimating()
			self.setTitle(self.buttonTitle, for: .normal)
			self.setImage(self.buttonImage, for: .normal)
		}
	}
}
