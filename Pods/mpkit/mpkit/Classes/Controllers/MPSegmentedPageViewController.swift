//
//  MPSegmentedPageViewController.swift
//  mpkit
//
//  Created by Martin Prot on 12/12/2017.
//  Copyright © 2017 Appricot media. All rights reserved.
//

import UIKit

open class MPSegmentedPageViewController: UIViewController {
	
	private let viewControllers: [UIViewController]
	
	public init(nibName: String? = .none, viewControllers: [UIViewController]) {
		self.viewControllers = viewControllers
		super.init(nibName: nibName, bundle: Bundle(for: type(of: self)))
	}
	
	public required init?(coder aDecoder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
	@IBOutlet public private(set) var segmentedControl: UISegmentedControl?
	@IBOutlet public private(set) var scrollView: UIScrollView?

	open override func viewDidLoad() {
		super.viewDidLoad()
				
		guard let scrollView = self.scrollView,
			  let segControl = self.segmentedControl
		else { return }
		
		var frame = scrollView.bounds
		segControl.removeAllSegments()
		
		self.viewControllers.forEach { vc in
			// adding segmented entry
			segControl.insertSegment(withTitle: vc.title, at: segControl.numberOfSegments, animated: false)
			
			// embedding vc
			vc.willMove(toParent: self)
			self.addChild(vc)
			vc.view.frame = frame
			scrollView.addSubview(vc.view)
			vc.view.autoresizingMask = [.flexibleHeight]
			vc.didMove(toParent: self)
			frame.origin.x += frame.size.width
		}
		scrollView.contentSize = CGSize(width: frame.origin.x, height: frame.height)
		segControl.selectedSegmentIndex = 0
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
	
	@IBAction private func onSegmentedChanged(_ sender: UISegmentedControl) {
		guard let width = self.scrollView?.bounds.width else { return }
		self.scrollView?.setContentOffset(CGPoint(x: width * sender.selectedSegmentIndex.cgFloat, y: 0), animated: true)
	}
}


////////////////////////////////////////////////////////////////////////////
// MARK: Scrollview delegate
////////////////////////////////////////////////////////////////////////////

extension MPSegmentedPageViewController: UIScrollViewDelegate {
	
	open func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
		guard let segControl = self.segmentedControl else { return }
		let page = Int(round(scrollView.contentOffset.x / scrollView.bounds.width))
		if page < segControl.numberOfSegments, segControl.selectedSegmentIndex != page {
			segControl.selectedSegmentIndex = page
		}
	}
	
}
