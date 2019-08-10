//
//  MPTextField.swift
//  mpkit
//
//  Created by Martin Prot on 29/05/2018.
//

import UIKit

/// A textfield with more control:
/// • border color & radius
/// • placeholder color
/// • horizontal text insets (same for left and right
open class MPTextField: UITextField {
	
	@IBInspectable var borderColor: UIColor = .clear { didSet { updateUI() } }
    @IBInspectable var borderSize: CGFloat = -1 { didSet { updateUI() } }
	@IBInspectable var cornerRadius: CGFloat = 0 { didSet { updateUI() } }
	@IBInspectable var placeholderColor: UIColor = .gray { didSet { updateUI() } }
	@IBInspectable var xTextInsets: CGFloat = 0 { didSet { self.setNeedsLayout() } }
	@IBInspectable var errorColor: UIColor = .red
	
	private var errorView: UIView?
	
	override open func awakeFromNib() {
		super.awakeFromNib()
		self.addTarget(self, action: #selector(textDidChange(_:)), for: .editingDidBegin)
	}
	
	@objc private func textDidChange(_ sender: MPTextField) {
		self.removeError()
	}
	
	private func updateUI() {
		if self.borderColor == .clear {
			self.layer.borderWidth = 0
		}
		else {
            if self.borderSize < 0 {
                self.layer.borderWidth = 1.0 / UIScreen.main.scale
            }
            else {
                self.layer.borderWidth = self.borderSize
            }
			self.layer.borderColor = self.borderColor.cgColor
		}
		
		self.layer.cornerRadius = self.cornerRadius
		if self.cornerRadius > 0 {
			self.clipsToBounds = false
		}
		if let text = self.placeholder {
			self.attributedPlaceholder = NSAttributedString(string: text,
															attributes: [.foregroundColor: self.placeholderColor])
		}
	}
	
	// placeholder position
	override open func textRect(forBounds bounds: CGRect) -> CGRect {
		return bounds.insetBy(dx: self.xTextInsets, dy: 0)
	}
	
	// text position
	override open func editingRect(forBounds bounds: CGRect) -> CGRect {
		return bounds.insetBy(dx: self.xTextInsets, dy: 0)
	}
	
	override open var placeholder: String? {
		didSet {
			guard let text = self.placeholder else { return }
			self.attributedPlaceholder = NSAttributedString(string: text,
															attributes: [.foregroundColor: self.placeholderColor])
		}
	}
	
	public func setError() {
		guard self.errorView == nil else { return }
		let errorView = UIView(frame: self.bounds)
		errorView.isUserInteractionEnabled = false
		errorView.layer.cornerRadius = self.cornerRadius
		errorView.clipsToBounds = true
		self.insertSubview(errorView, at: 0)
		errorView.backgroundColor = self.errorColor
		self.errorView = errorView
	}
	
	public func removeError() {
		self.errorView?.removeFromSuperview()
		self.errorView = nil
	}
}
