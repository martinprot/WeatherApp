//
//  UIImage+resize.swift
//  mpkit
//
//  Created by Martin Prot on 12/10/2018.
//

import UIKit

extension UIImage {
	
	public func imageWith(newSize: CGSize) -> UIImage {
		guard #available(iOS 10.0, *) else { return self }
		let renderer = UIGraphicsImageRenderer(size: newSize)
		return renderer.image { _ in
			self.draw(in: CGRect.init(origin: CGPoint.zero, size: newSize))
		}
	}
	
	public func imageWith(newWidth: CGFloat) -> UIImage {
		let ratio = self.size.width / self.size.height
		return self.imageWith(newSize: CGSize(width: newWidth, height: newWidth / ratio))
	}
}
