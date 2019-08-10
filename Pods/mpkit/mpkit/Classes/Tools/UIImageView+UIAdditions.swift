//
//  UIImageView+UIAdditions.swift
//  mpkit
//
//  Created by Martin Prot on 30/08/2017.
//  Copyright © 2017 Appricot media. All rights reserved.
//

import UIKit

extension UIImageView {
	@IBInspectable public var tintedImage: Bool {
		get {
			guard let image = self.image else { return false }
			return image.renderingMode == .alwaysTemplate
		}
		set {
			guard let image = self.image else { return }
			if newValue {
				let color = self.tintColor
				self.image = image.tinted
				self.tintColor = color
			}
			else {
				self.image = image.notTinted
			}
		}
	}
	
	public func tintMe() {
		self.image = self.image?.tinted
	}
	
	public var bestWidthForCurrentImageHeight: CGFloat {
		guard let imageSize = self.image?.size else {
			return 0
		}
		return self.bounds.height * imageSize.width / imageSize.height
	}
	
	public var bestHeightForCurrentImageWidth: CGFloat {
		guard let imageSize = self.image?.size else {
			return 0
		}
		return self.bounds.width * imageSize.height / imageSize.width
	}
}

extension UIImage {
	/// Creates a 1px UIImage from and UIColor
	/// This is useful for your UIButton to set filled background color for states
	///
	/// - parameter color: Based color for image generation
	///
	/// - returns: UIImage generated for the designated color
	public static func onePixel(of color: UIColor) -> UIImage? {
		return self.from(color: color, size: CGSize(width: 1, height: 1), cornerRadius: 0, borderColor: .clear, borderSize: 0)
	}
	
	/// Creates an UIImage from and UIColor
	///
	/// - parameter color: Based color for image generation
	/// - parameter size: Based size for image generation
	/// - parameter cornerRadius: Based cornerRadius for image generation
	///
	/// - returns: UIImage generated for the designated color
	public static func from(color: UIColor, size: CGSize, cornerRadius: CGFloat = 0, borderColor: UIColor? = .none, borderSize: CGFloat = 0) -> UIImage? {
		
		let rect = CGRect(origin: CGPoint.zero, size: size)
		
		UIGraphicsBeginImageContext(rect.size)
		let context = UIGraphicsGetCurrentContext()
		let bezierPath = UIBezierPath(roundedRect: rect, cornerRadius: cornerRadius)
		context?.setFillColor(color.cgColor)
		bezierPath.fill()
		if let borderColor = borderColor, borderSize > 0 {
			context?.setStrokeColor(borderColor.cgColor)
			context?.setLineWidth(borderSize)
			bezierPath.stroke()
		}
		let image = UIGraphicsGetImageFromCurrentImageContext()
		UIGraphicsEndImageContext()
		
		return image
	}
	
}


extension UIImage {

    public var tinted: UIImage {
        return self.withRenderingMode(.alwaysTemplate)
    }
    public var notTinted: UIImage {
        return self.withRenderingMode(.alwaysOriginal)
    }
}
