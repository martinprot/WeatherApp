//
//  UIScrollView+scrollingstuff.swift
//  ImageLoader
//
//  Created by Martin Prot on 27/08/2018.
//

import Foundation

extension UIScrollView {
	public func scrollToTop(animated: Bool = true) {
		self.scrollRectToVisible(CGRect(x: 0, y: 0, width: 1, height: 1), animated: animated)
	}
	
	public func scrollToBottom(animated: Bool = true) {
		self.scrollRectToVisible(CGRect(x: 0, y: self.contentSize.height, width: 1, height: 1), animated: animated)
	}
}
