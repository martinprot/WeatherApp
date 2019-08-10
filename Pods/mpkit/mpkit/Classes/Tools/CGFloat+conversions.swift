//
//  CGFloat+conversions.swift
//  mpkit
//
//  Created by Martin Prot on 06/12/2017.
//  Copyright © 2017 Appricot media. All rights reserved.
//

import UIKit

protocol CGFloatConvertible {
	var cgFloat: CGFloat { get }
}

extension Int: CGFloatConvertible {
	public var cgFloat: CGFloat {
		return CGFloat(self)
	}
}

extension Double: CGFloatConvertible {
	public var cgFloat: CGFloat {
		return CGFloat(self)
	}
}

extension Float: CGFloatConvertible {
	public var cgFloat: CGFloat {
		return CGFloat(self)
	}
}

