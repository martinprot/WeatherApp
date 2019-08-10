//
//  String+checks.swift
//  mpkit
//
//  Created by Martin Prot on 17/07/2018.
//

import Foundation

extension String {
	/**
	*  Checks if it's a well formatted email
	*
	*/
	public var isEmail: Bool {
		let regex = try? NSRegularExpression(pattern: "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]+", options: .caseInsensitive)
		return regex?.firstMatch(in: self, options: [], range: NSRange(location: 0, length: self.count)) != nil
	}
	
	public var isEmpty: Bool {
		return self.count == 0
	}
}

extension Optional where Wrapped == String {
	
	public var isEmail: Bool {
		switch self {
		case .none: return false
		case .some(let string): return string.isEmail
		}
	}
	
	public var isEmpty: Bool {
		switch self {
		case .none: return true
		case .some(let string): return string.isEmpty
		}
	}
}
