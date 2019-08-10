//
//  MPPageViewController.swift
//  ImageLoader
//
//  Created by Martin Prot on 11/09/2018.
//

import UIKit

open class MPPageViewController: UIViewController {
	
	private let viewControllers: [UIViewController]
	@IBOutlet private var pageControl: UIPageControl?
	
	public private(set) var currentPage: Int = 0 {
		didSet {
			self.pageControl?.currentPage = self.currentPage
			self.pageDidChange()
		}
	}
	public var pageCount: Int { return self.viewControllers.count }
	public var isLastPage: Bool { return self.currentPage == self.pageCount-1 }
	
	public init(nibName: String? = .none, viewControllers: [UIViewController]) {
		self.viewControllers = viewControllers
		super.init(nibName: nibName, bundle: Bundle(for: type(of: self)))
	}
	
	public required init?(coder aDecoder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
	@IBOutlet public private(set) var scrollView: UIScrollView?
	
	open override func viewDidLoad() {
		super.viewDidLoad()
		
		guard let scrollView = self.scrollView else { return }
		scrollView.isPagingEnabled = true
		scrollView.showsVerticalScrollIndicator = false
		scrollView.showsHorizontalScrollIndicator = false
		
		self.pageControl?.numberOfPages = self.viewControllers.count
		self.currentPage = 0
		
		self.viewControllers.forEach { vc in
			self.embed(viewController: vc, in: scrollView)
			vc.view.autoresizingMask = [.flexibleHeight]
		}
		self.updateEmbeddedControllerFrames()
	}
	
	open override func viewDidLayoutSubviews() {
		super.viewDidLayoutSubviews()
		self.updateEmbeddedControllerFrames()
	}
	
	private func updateEmbeddedControllerFrames() {
		guard let scrollView = self.scrollView else { return }
		var frame = scrollView.bounds
		self.viewControllers.forEach { vc in
			vc.view.frame = frame
			frame.origin.x += frame.size.width
		}
		scrollView.contentSize = CGSize(width: frame.origin.x, height: frame.height)
	}
	
	public func set(page: Int) {
		guard page < self.viewControllers.count else { return }
		guard let width = self.scrollView?.bounds.width else { return }
		self.scrollView?.setContentOffset(CGPoint(x: width * page.cgFloat, y: 0), animated: true)
		self.currentPage = page
	}
	
	open func pageDidChange() {
		
	}
}


////////////////////////////////////////////////////////////////////////////
// MARK: Scrollview delegate
////////////////////////////////////////////////////////////////////////////

extension MPPageViewController: UIScrollViewDelegate {
	
	open func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
		let page = Int(round(scrollView.contentOffset.x / scrollView.bounds.width))
		if page < self.pageCount, self.currentPage != page {
			self.currentPage = page
		}
	}
	
}
