//
//  Bundle+modules.swift
//  mpkit
//
//  Created by Martin Prot on 12/03/2018.
//  Copyright © 2018 Appricot media. All rights reserved.
//

import Foundation

extension Bundle {
	
	public var displayName: String? {
		return object(forInfoDictionaryKey: "CFBundleDisplayName") as? String
	}
}
