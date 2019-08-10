//
//  KeyboardInsetHandler.swift
//  mpkit
//
//  Created by Martin Prot on 29/08/2018.
//  Copyright © 2018 Appricot media. All rights reserved.
//

import UIKit

/// Automatically handles the keyboard insets to the injected scrollview
final public class KeyboardInsetHandler {
    private var scrollView: UIScrollView?
	private var safeBottomArea: CGFloat?
	
    /// the scrollview inset to revert after the keyboard will fold
	/// if not set, the inset handler takes the scrollview inset found when keyboard opens
    public var defaultInsets: UIEdgeInsets?
	/// the scroll bar inset to revert after the keyboard will fold
	/// if not set, the inset handler takes the same value as the defaultInsets
	public var defaultIndicatorInsets: UIEdgeInsets?

    public init(scrollView: UIScrollView? = .none) {
        self.scrollView = scrollView
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(self.onKeyboardWillShow(_:)),
                                               name: UIResponder.keyboardDidShowNotification, object: nil)
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(self.onKeyboardDidHide(_:)),
                                               name: UIResponder.keyboardDidHideNotification, object: nil)
    }
	
	public func handle(scrollView: UIScrollView?) {
		self.scrollView = scrollView
	}

    deinit {
        NotificationCenter.default.removeObserver(self)
    }

    @objc private func onKeyboardWillShow(_ notification: Notification) {
        guard let userInfo = notification.userInfo,
            let keyboardRectValue = userInfo[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue
            else { return }
        if self.defaultInsets == nil {
            self.defaultInsets = self.scrollView?.contentInset
        }
		//
		let safeBottomArea: CGFloat
		if #available(iOS 11.0, *) {
			safeBottomArea = self.scrollView?.safeAreaInsets.bottom ?? 0
		} else {
			safeBottomArea = 0
		}
		
        var insets = self.scrollView?.contentInset ?? .zero
        insets.bottom = keyboardRectValue.cgRectValue.size.height - safeBottomArea
        self.scrollView?.contentInset = insets
		var indicatorInsets = self.defaultIndicatorInsets ?? insets
		indicatorInsets.bottom = insets.bottom
        self.scrollView?.scrollIndicatorInsets = indicatorInsets
    }

    @objc private func onKeyboardDidHide(_ notification: Notification) {
        let insets = self.defaultInsets ?? .zero
        self.scrollView?.contentInset = insets
        self.scrollView?.scrollIndicatorInsets = self.defaultIndicatorInsets ?? insets
    }
}
