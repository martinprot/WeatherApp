//
//  MPPartiallyModalViewController.swift
//  mpkit
//
//  Created by Martin Prot on 29/03/2018.
//  Copyright © 2018 Appricot media. All rights reserved.
//

import UIKit

public protocol MPPartiallyModalViewControllerDelegate: class {
    func controllerDidDismiss(_ controller: MPPartiallyModalViewController)
}

public final class MPPartiallyModalViewController: UIViewController {

    public enum Offset {
        case halfScreen
        case firstThird
        case lastThird
        case custom(CGFloat)

        func size(for embeddingHeight: CGFloat) -> CGFloat {
            switch self {
            case .halfScreen:
                return embeddingHeight/2
            case .firstThird:
                return 2*embeddingHeight/3
            case .lastThird:
                return embeddingHeight/3
            case .custom(let offset):
                return embeddingHeight - offset
            }
        }
    }

    private let backgroundAlpha: CGFloat = 0.5
    private let animationDuration: TimeInterval = 0.4

    private let offset: Offset
    private let viewController: UIViewController
    public weak var delegate: MPPartiallyModalViewControllerDelegate?

    private let blackView = UIView()

    public init(embeddedViewController: UIViewController, offset: Offset = .halfScreen) {
        self.viewController = embeddedViewController
        self.offset = offset
        super.init(nibName: nil, bundle: nil)
        self.modalPresentationStyle = .overCurrentContext
        self.modalTransitionStyle = .crossDissolve
    }

    convenience init() {
        fatalError("Please call init(embeddedViewController:offset:) to create this view controller")
    }

    required public init?(coder aDecoder: NSCoder) {
        fatalError("Please call init(embeddedViewController:offset:) to create this view controller")
    }

    override public func viewDidLoad() {
        super.viewDidLoad()

        // blackview
        self.view.addSubview(blackView)
        self.blackView.frame = self.view.bounds
        self.blackView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        self.blackView.backgroundColor = .black
        self.blackView.alpha = self.backgroundAlpha

        // child view controlled
        viewController.willMove(toParent: self)
        addChild(viewController)
        self.view.addSubview(viewController.view)
        viewController.didMove(toParent: self)
        let height = self.view.bounds.height - self.offset.size(for: self.view.bounds.height)
        self.viewController.view.frame = CGRect(x: 0, y: self.view.frame.maxY - height,
                                                width: self.view.frame.width, height: height)
        self.viewController.view.transform = CGAffineTransform(translationX: 0, y: height)
        self.viewController.view.autoresizingMask = [.flexibleWidth, .flexibleHeight]

        // GestureRecognizer
        let recognizer = UITapGestureRecognizer(target: self, action: #selector(self.onClose(_:)))
        self.blackView.addGestureRecognizer(recognizer)
    }

    override public func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        guard animated else { return }

        UIView.animate(withDuration: self.animationDuration) {
            self.viewController.view.transform = .identity
        }
    }

    override public func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        guard animated else { return }
        UIView.animate(withDuration: self.animationDuration) {
            let height = self.viewController.view.frame.height
            self.viewController.view.transform = CGAffineTransform(translationX: 0, y: height)
        }
    }

    @objc private func onClose(_ sender: Any) {
        self.dismiss(animated: true) {
            self.delegate?.controllerDidDismiss(self)
        }
    }
}
