//
//  UISegmentedControl+fastfullfill.swift
//  ImageLoader
//
//  Created by Martin Prot on 19/07/2018.
//

import UIKit

extension UISegmentedControl {
	
	public func set(segmentTitles titles: [String]) {
		let selected = self.selectedSegmentIndex
		self.removeAllSegments()
		titles.enumerated().forEach { offset, title in
			self.insertSegment(withTitle: title, at: offset, animated: false)
		}
		if selected >= 0, selected < titles.count {
			self.selectedSegmentIndex = selected
		}
	}
}

