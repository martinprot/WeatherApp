//
//  UIGradientView.swift
//  mpkit
//
//  Created by Martin Prot on 10/08/2017.
//  Copyright © 2017 Appricot media. All rights reserved.
//

import UIKit

//@IBDesignable

final public class UIGradientView: UIView {
	
	@IBInspectable public var startColor:   UIColor = .black { didSet { updateColors() }}
	@IBInspectable public var endColor:     UIColor = .white { didSet { updateColors() }}
    @IBInspectable public var isVertical:   Bool = true      { didSet { updateColors() }}
	
	override public class var layerClass: AnyClass { return CAGradientLayer.self }
	
	private var gradientLayer: CAGradientLayer? { return layer as? CAGradientLayer }
	
	private func updateLayer() {
        if isVertical {
            self.gradientLayer?.startPoint = CGPoint(x: 0.5, y: 0)
            self.gradientLayer?.endPoint   = CGPoint(x: 0.5, y: 1)
        }
        else {
            self.gradientLayer?.startPoint = CGPoint(x: 0, y: 0.5)
            self.gradientLayer?.endPoint   = CGPoint(x: 1, y: 0.5)
        }
		self.gradientLayer?.locations = [0, 1]
	}
	private func updateColors() {
		self.gradientLayer?.colors    = [startColor.cgColor, endColor.cgColor]
	}
	
	public override func layoutSubviews() {
		super.layoutSubviews()
		updateLayer()
		updateColors()
	}
}
