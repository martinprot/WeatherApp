//
//  UIProgressButton.swift
//  mpkit
//
//  Created by Martin Prot on 07/05/2019.
//

import UIKit

open class UIProgressButton: UIButton {
	
	lazy private var progressLayer: CAShapeLayer = {
		let layer = CAShapeLayer()
		layer.strokeColor = self.progressColor.cgColor
		layer.fillColor = UIColor.clear.cgColor
		layer.strokeEnd = 0
		layer.isHidden = true
		layer.lineWidth = self.borderSize
		return layer
	}()
	
	lazy private var remainingLayer: CAShapeLayer = {
		let layer = CAShapeLayer()
		layer.strokeColor = self.remainingColor.cgColor
		layer.fillColor = UIColor.clear.cgColor
		layer.strokeEnd = 0
		layer.isHidden = true
		layer.lineWidth = self.borderSize
		return layer
	}()
	
	open override func awakeFromNib() {
		super.awakeFromNib()
		self.layer.addSublayer(self.remainingLayer)
		self.layer.addSublayer(self.progressLayer)
	}
	
	@IBInspectable var progressColor: UIColor = .black
	@IBInspectable var remainingColor: UIColor = .clear
	@IBInspectable var borderSize: CGFloat = 1
	@IBInspectable var loadingImage: UIImage = UIImage()
	@IBInspectable var progressOffset: CGFloat = 4
	
	private var previousImage: UIImage?
	
	public var completion: CGFloat = 0 {
		didSet {
			self.progressLayer.isHidden = self.completion == 0
			self.progressLayer.strokeEnd = self.completion
			self.setNeedsLayout()
			self.layoutIfNeeded()
		}
	}
	
	public private(set) var isLoading: Bool = false
	
	public func startLoading() {
		self.isLoading = true
		self.previousImage = self.image(for: self.state)
		self.setImage(self.loadingImage, for: self.state)
	}
	
	public func stopLoading() {
		self.isLoading = false
		self.completion = 0
		
		self.setImage(self.previousImage, for: self.state)
	}
	
	open override func layoutSubviews() {
		super.layoutSubviews()
		
		let radius: CGFloat
		guard
			let imageView = self.imageView,
			let center = self.imageView?.superview?.convert(imageView.center, to: self)
			else { return }
		if loadingImage.size.width == 0 {
			radius = min(self.bounds.width, self.bounds.height)/2
		}
		else {
			radius = min(loadingImage.size.width, loadingImage.size.height)/2 + self.progressOffset*2
		}
		
		if isLoading {
			let startAngle = 3*CGFloat.pi/2
			let endAngle = startAngle + CGFloat.pi*2
			let path = UIBezierPath(arcCenter: center, radius: radius, startAngle: startAngle, endAngle: endAngle, clockwise: true)
			self.progressLayer.path = path.cgPath
			let remainingPath = UIBezierPath(arcCenter: center, radius: radius, startAngle: startAngle, endAngle: endAngle, clockwise: true)
			self.remainingLayer.path = remainingPath.cgPath
		}
	}
}

