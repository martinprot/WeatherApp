//
//  MPChoicesViewController.swift
//  mpkit
//
//  Created by Martin Prot on 11/01/2019.
//

import UIKit

/// A simple viewcontroller prompting user to select choices, exactly as a UIAlertController does with the UIActionSheet mode.
/// unlike UIAlertController, it can be stacked into a navigation controller
/// TODO: add configuration for title, message, and cells.
public class MPChoicesViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
	
	private struct Defaults {
		static let titleAttributes: [NSAttributedString.Key: Any] = [.font: UIFont.systemFont(ofSize: 15, weight: .semibold),
																	 .foregroundColor: UIColor.gray]
		static let messageAttributes: [NSAttributedString.Key: Any] = [.font: UIFont.systemFont(ofSize: 15),
																	   .foregroundColor: UIColor.gray]
		static let cellAttributes: [NSAttributedString.Key: Any] = [.font: UIFont.systemFont(ofSize: 17),
																	.foregroundColor: UIButton(type: .system).titleColor(for: .normal) ?? .black]
		static let padding: CGFloat = 16
		static let spacing: CGFloat = 8
	}
	
	public struct Option {
		let title: String
		let handler: () -> ()
	}
	
	public let prompt: String?
	public let message: String?
	
	private var titleLabel: UILabel?
	private var messageLabel: UILabel?
	private var stackView: UIStackView?
	private var tableView: UITableView?
	
	private var options: [Option]
	
	public var preferredHeight: CGFloat {
		self.view.layoutNow()
		var height = Defaults.padding * 2 + (self.tableView?.contentSize.height ?? 0)
		if let titleView = self.titleLabel {
			height += titleView.bounds.height + (self.stackView?.spacing ?? 0)
		}
		if let messageView = self.messageLabel {
			height += messageView.bounds.height + (self.stackView?.spacing ?? 0)
		}
		return height - 1 // dont display last cell separator
	}
	
	public func add(option: Option) {
		self.options.append(option)
	}
	
	public init(title: String?, message: String?, options: [Option] = []) {
		self.prompt = title
		self.message = message
		self.options = options
		super.init(nibName: nil, bundle: nil)
	}
	
	required init?(coder aDecoder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
	public override func viewDidLoad() {
		super.viewDidLoad()
		let tableView = UITableView(frame: self.view.bounds)
		tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
		tableView.dataSource = self
		tableView.delegate = self
		tableView.backgroundColor = .clear
		self.tableView = tableView
		
		let stackView = UIStackView(frame: self.view.bounds.insetBy(dx: Defaults.padding, dy: Defaults.padding))
		stackView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
		stackView.axis = .vertical
		stackView.distribution = .fill
		stackView.alignment = .fill
		stackView.spacing = Defaults.spacing
		
		if let title = self.prompt {
			let titleLabel = UILabel()
			titleLabel.textAlignment = .center
			titleLabel.attributedText = NSAttributedString(string: title, attributes: Defaults.titleAttributes)
			stackView.addArrangedSubview(titleLabel)
			self.titleLabel = titleLabel
		}
		if let message = self.message {
			let messageLabel = UILabel()
			messageLabel.textAlignment = .center
			messageLabel.attributedText = NSAttributedString(string: message, attributes: Defaults.messageAttributes)
			stackView.addArrangedSubview(messageLabel)
			self.messageLabel = messageLabel
		}
		stackView.addArrangedSubview(tableView)
		self.stackView = stackView
		self.view.addSubview(stackView)
	}
	
	public func numberOfSections(in tableView: UITableView) -> Int {
		return 1
	}
	
	public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return options.count
	}
	
	public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		guard let cell = tableView.dequeueReusableCell(withIdentifier: "cell") else {
			fatalError("cell identifier does not exist")
		}
		cell.textLabel?.attributedText = NSAttributedString(string: options[indexPath.row].title, attributes: Defaults.cellAttributes)
		cell.textLabel?.textAlignment = .center
		cell.backgroundColor = .clear
		return cell
	}
	
	public func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
		let option = self.options[indexPath.row]
		option.handler()
	}
}
