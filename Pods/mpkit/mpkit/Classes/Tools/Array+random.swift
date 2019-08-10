//
//  Array+random.swift
//  mpkit
//
//  Created by Martin Prot on 08/12/2017.
//  Copyright © 2017 Appricot media. All rights reserved.
//

import Foundation

extension Array {
	
	public var randomElement: Element? {
		guard self.count > 0 else { return .none }
		return self[Int(arc4random_uniform(UInt32(self.count)))]
	}
}
