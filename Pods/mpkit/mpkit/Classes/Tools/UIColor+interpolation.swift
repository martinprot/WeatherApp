//
//  UIColor+interpolation.swift
//  mpkit
//
//  Created by Martin Prot on 13/03/2018.
//  Copyright © 2017 Appricot media. All rights reserved.
//

import Foundation

extension UIColor {
	
	public convenience init(r: Int, g: Int, b: Int) {
		self.init(red: CGFloat(r)/255.0, green: CGFloat(g)/255.0, blue: CGFloat(b)/255.0, alpha: 1)
	}
	public convenience init(w: Int) {
		self.init(red: CGFloat(w)/255.0, green: CGFloat(w)/255.0, blue: CGFloat(w)/255.0, alpha: 1)
	}
	
	public static func interpolation(beetween color1: UIColor, and color2: UIColor, completion: CGFloat) -> UIColor {
		var r1: CGFloat = 0
		var g1: CGFloat = 0
		var b1: CGFloat = 0
		var r2: CGFloat = 0
		var g2: CGFloat = 0
		var b2: CGFloat = 0
		guard color1.getRed(&r1, green: &g1, blue: &b1, alpha: nil),
			color2.getRed(&r2, green: &g2, blue: &b2, alpha: nil)
			else {
				return color1
		}
		let r: CGFloat = (1.0 - completion) * r1 + completion * r2
		let g: CGFloat = (1.0 - completion) * g1 + completion * g2
		let b: CGFloat = (1.0 - completion) * b1 + completion * b2
		return UIColor(red: r, green: g, blue: b, alpha: 1)
	}
	
}
