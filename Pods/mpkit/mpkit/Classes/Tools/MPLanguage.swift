//
//  MPLanguage.swift
//  mpkit
//
//  Created by Martin Prot on 05/10/2017.
//  Copyright © 2017 Appricot media. All rights reserved.
//

import Foundation

extension Notification.Name {
	public static let MPLanguageChanged = Notification.Name("MPLanguageChangedNotification")
}

public struct MPLanguage: Equatable {
	let isoCode: String
	
	private static let userDefaultKey = "MPCurrentLanguage"
	
	public static let `default`: MPLanguage = MPLanguage(from: "en")
	
	public static var current: MPLanguage {
		get {
			guard let lang = UserDefaults.standard.string(forKey: MPLanguage.userDefaultKey) else {
				return NSLocale.preferredLanguages.first.map { MPLanguage(from: $0) } ?? .default
			}
			return MPLanguage(from: lang)
		}
		set {
			UserDefaults.standard.set(newValue.toString, forKey: MPLanguage.userDefaultKey)
			NotificationCenter.default.post(name: .MPLanguageChanged, object: nil)
		}
	}
	
	public var toString: String {
		return isoCode
	}
	
	public init(from: String) {
		if let range = from.range(of: "-") {
			let sub = String(from[..<range.lowerBound])
			self.isoCode = sub
		}
		else {
			self.isoCode = from
		}
	}
}

extension String {
	
	public var localized: String {
		return self.localized(bundle: Bundle.main)
	}
	
	public func localized(bundle: Bundle) -> String {
		let currentLanguage = MPLanguage.current
		let path = bundle.path(forResource: currentLanguage.toString, ofType: "lproj") ??
					bundle.path(forResource: MPLanguage.default.toString, ofType: "lproj")
		
		guard let langBundle = path.flatMap({Bundle(path: $0)}) else { return self }
		if ProcessInfo.processInfo.arguments.contains("showLocalizationIssues") {
			let notFound = "notfound"
			let text = langBundle.localizedString(forKey: self, value: notFound, table: nil)
			if text == notFound {
				print("[LOCALIZATION ISSUE] \"\(self)\" not found")
				return self
			}
			else {
				return text
			}
		}
		else {
			return langBundle.localizedString(forKey: self, value: nil, table: nil)
		}
	}
}
