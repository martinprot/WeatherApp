//
//  MPButtonExternalImage.swift
//  mpkit
//
//  Created by Martin Prot on 29/04/2019.
//

import UIKit

public class MPButtonExternalImage: UIButton {
	private let highlightAlpha: CGFloat = 0.2
	private let disabledAlpha: CGFloat = 0.4
	
	@IBOutlet private var externalImageView: UIImageView?
	
	public override func awakeFromNib() {
		super.awakeFromNib()
		self.externalImageView?.tintMe()
		self.externalImageView?.tintColor = self.titleColor(for: self.state)
	}
	
	public override var isHighlighted: Bool {
		didSet {
			self.externalImageView?.tintColor = self.titleColor(for: self.state)
		}
	}
	
	public override var isEnabled: Bool {
		didSet {
			self.externalImageView?.tintColor = self.titleColor(for: self.state)
		}
	}
	
	public override var isSelected: Bool {
		didSet {
			self.externalImageView?.tintColor = self.titleColor(for: self.state)
			self.externalImageView?.isHighlighted = self.isSelected
		}
	}
}
