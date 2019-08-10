//
//  UIView+nib.swift
//  mpkit
//
//  Created by Martin Prot on 19/07/2018.
//

import UIKit

extension UIView {
	
	/// instanciates the view associated to the given nib name. If the nib name is not set,
	/// takes the nib name with the same name of the UIView subclass
	public static func fromNib<T: UIView>(named nibName: String? = .none) -> T {
		guard let view = Bundle.main.loadNibNamed(nibName ?? String(describing: T.self), owner: nil, options: nil)?.first as? T else {
			fatalError("No view of type \(T.self) found")
		}
		return view
	}
}
