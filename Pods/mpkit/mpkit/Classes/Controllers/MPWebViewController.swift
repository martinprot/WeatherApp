//
//  MPWebViewController.swift
//  mpkit
//
//  Created by Martin Prot on 14/03/2018.
//

import Foundation
import WebKit

open class MPWebViewController: UIViewController {
	
	public convenience init(url: String, loadImmediately: Bool = false) {
		self.init()
		self.url = url
		
		if loadImmediately {
			self.loadViewIfNeeded()
		}
	}
	
	@IBInspectable private var url: String = ""
	
	@IBOutlet private var webViewContainer: UIView?
	@IBOutlet private var activity: UIActivityIndicatorView?
	public private(set) var webView: WKWebView?
	
	open override func viewDidLoad() {
		super.viewDidLoad()
		
		guard let container = self.webViewContainer ?? self.view else { return }
		let webView = WKWebView(frame: container.bounds)
		webView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
		webView.navigationDelegate = self
		container.addSubview(webView)
		self.webView = webView
		
		if self.activity == nil {
			let activity = UIActivityIndicatorView(style: .gray)
			activity.center = CGPoint(self.view.bounds.size / 2)
			activity.autoresizingMask = [.flexibleTopMargin, .flexibleBottomMargin,
										 .flexibleRightMargin, .flexibleLeftMargin]
			self.view.addSubview(activity)
			self.activity = activity
		}
		self.load(url: URL(string: self.url))
	}
	
	public func load(url: URL?) {
		if let url = url {
			self.webView?.load(URLRequest(url: url))
			self.activity?.startAnimating()
		}
	}
}

extension MPWebViewController: WKNavigationDelegate {
	
	public func webView(_ webView: WKWebView, didStartProvisionalNavigation navigation: WKNavigation) {
		self.activity?.startAnimating()
	}
	
	public func webView(_ webView: WKWebView, didFail navigation: WKNavigation, withError error: Error) {
		self.activity?.stopAnimating()
	}
	
	public func webView(_ webView: WKWebView, didFinish navigation: WKNavigation) {
		self.activity?.stopAnimating()
	}
}

