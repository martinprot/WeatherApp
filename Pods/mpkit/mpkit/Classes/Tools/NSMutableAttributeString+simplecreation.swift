//
//  NSMutableAttributeString+simplecreation.swift
//  mpkit
//
//  Created by Martin Prot on 31/07/2018.
//

import Foundation

extension NSMutableAttributedString {
	
	public convenience init(attributedCouples: [(text: String, attributes: [NSAttributedString.Key : Any])]) {
		self.init()
		attributedCouples.forEach { couple in
			self.append(NSMutableAttributedString(string: couple.text, attributes: couple.attributes))
		}
	}
}
