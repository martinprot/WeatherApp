//
//  UICircleView.swift
//  mpkit
//
//  Created by Martin Prot on 01/03/20178.
//  Copyright © 2017 Appricot media. All rights reserved.
//

import UIKit

//@IBDesignable

final public class UICircleView: UIView {
	
	public override func layoutSubviews() {
		super.layoutSubviews()
		self.layer.cornerRadius = min(self.bounds.width, self.bounds.height)/2
		self.clipsToBounds = true
	}
}
