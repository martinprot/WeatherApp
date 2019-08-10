//
//  String+size.swift
//  mpkit
//
//  Created by Martin Prot on 20/06/2018.
//

import Foundation

extension String {
	public func size(constrainedToWidth width: CGFloat = .greatestFiniteMagnitude,
			  constrainedToHeight height: CGFloat = .greatestFiniteMagnitude,
			  font: UIFont) -> CGSize {
		let constraintRect = CGSize(width: width, height: height)
		let boundingBox = self.boundingRect(with: constraintRect, options: .usesLineFragmentOrigin, attributes: [.font: font], context: nil)
		return CGSize(width: ceil(boundingBox.width), height: ceil(boundingBox.height))
	}
	
	public func width(constrainedToHeight height: CGFloat = .greatestFiniteMagnitude, font: UIFont) -> CGFloat {
		return self.size(constrainedToHeight: height, font: font).width
	}
	
	public func height(constrainedToWidth width: CGFloat = .greatestFiniteMagnitude, font: UIFont) -> CGFloat {
		return self.size(constrainedToWidth: width, font: font).height
	}
}
