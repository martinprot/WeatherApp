//
//  MPButtonRightImage.swift
//  mpkit
//
//  Created by Martin Prot on 29/04/2019.
//

import UIKit

public class MPButtonRightImage: UIButton {
	private let imageMargin: CGFloat = 8
	private let highlightAlpha: CGFloat = 0.2
	private let disabledAlpha: CGFloat = 0.4
	
	private lazy var rightImageView: UIImageView = {
		let view = UIImageView()
		view.tintColor = self.tintColor
		self.addSubview(view)
		return view
	}()
	
	@IBInspectable public var rightImage: UIImage? {
		didSet {
			self.layoutImage()
		}
	}
	
	public override func layoutSubviews() {
		super.layoutSubviews()
		self.layoutImage()
	}
	
	private func layoutImage() {
		guard let image = self.rightImage else { return }
		self.rightImageView.image = image
		
		let inset = image.size.width + self.imageMargin
		self.rightImageView.frame = CGRect(x: 0, y: 0, width: image.size.height, height: image.size.height)
		self.rightImageView.center = CGPoint(x: self.bounds.maxX - image.size.width/2, y: self.bounds.midY)
		self.titleEdgeInsets = UIEdgeInsets(top: 0, left: -inset, bottom: 0, right: inset)
		self.contentEdgeInsets = UIEdgeInsets(top: 0, left: inset, bottom: 0, right: 0)
	}
	
	public override var isHighlighted: Bool {
		didSet {
			guard self.rightImage != nil else { return }
			
			if self.isHighlighted {
				self.rightImageView.alpha = self.highlightAlpha
			}
			else {
				UIView.animate(withDuration: .quickAnimationDuration, animations: {
					self.rightImageView.alpha = 1
				})
			}
		}
	}
	
	public override var isEnabled: Bool {
		didSet {
			if self.isEnabled {
				self.rightImageView.tintColor = self.tintColor
				self.rightImageView.alpha = 1
			}
			else {
				switch self.rightImage?.renderingMode {
				case .alwaysTemplate?:
					self.rightImageView.tintColor = self.titleLabel?.textColor
				default:
					self.rightImageView.alpha = self.disabledAlpha
				}
				
			}
		}
	}
	
}
