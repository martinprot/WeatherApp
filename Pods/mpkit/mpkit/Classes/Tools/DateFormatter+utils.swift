//
//  DateFormatter+utils.swift
//  Bolts
//
//  Created by Martin Prot on 05/10/2018.
//

import Foundation

extension DateFormatter {
	
	public convenience init(format: String) {
		self.init()
		self.dateFormat = format
	}
	
	public convenience init(dateStyle: DateFormatter.Style, timeStyle: DateFormatter.Style = .none) {
		self.init()
		self.dateStyle = dateStyle
		self.timeStyle = timeStyle
	}
	
}
