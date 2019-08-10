//
//  CGPoint+operations.swift
//  mpkit
//
//  Created by Martin Prot on 12/12/2017.
//  Copyright © 2017 Appricot media. All rights reserved.
//

import UIKit

extension CGPoint {
	
	public init(_ size: CGSize) {
		self.init(x: size.width, y: size.height)
	}
	
	public static func +(left: CGPoint, right: CGPoint) -> CGPoint {
		return CGPoint(x: left.x + right.x, y: left.y + right.y)
	}
	public static func -(left: CGPoint, right: CGPoint) -> CGPoint {
		return CGPoint(x: left.x - right.x, y: left.y - right.y)
	}

}

extension CGSize {
	
	public init(_ point: CGPoint) {
		self.init(width: point.x, height: point.y)
	}
	
	public static func +(left: CGSize, right: CGSize) -> CGSize {
		return CGSize(width: left.width + right.width, height: left.height + right.height)
	}
	
	public static func -(left: CGSize, right: CGSize) -> CGSize {
		return CGSize(width: left.width - right.width, height: left.height - right.height)
	}
	
	public static func *(left: CGSize, right: CGFloat) -> CGSize {
		return CGSize(width: left.width * right, height: left.height * right)
	}
	
	public static func /(left: CGSize, right: CGFloat) -> CGSize {
		return CGSize(width: left.width / right, height: left.height / right)
	}
}

extension CGRect {
	public func changing(x: CGFloat) -> CGRect { return CGRect(x: x, y: self.minY, width: self.width, height: self.height) }
	public func changing(y: CGFloat) -> CGRect { return CGRect(x: self.minX, y: y, width: self.width, height: self.height) }
	public func changing(width: CGFloat) -> CGRect { return CGRect(x: self.minX, y: self.minY, width: width, height: self.height) }
	public func changing(height: CGFloat) -> CGRect { return CGRect(x: self.minX, y: self.minY, width: self.width, height: height) }
	
	public func adding(x: CGFloat) -> CGRect { return self.changing(x: self.minX + x) }
	public func adding(y: CGFloat) -> CGRect { return self.changing(y: self.minY + y) }
	public func adding(width: CGFloat) -> CGRect { return self.changing(width: self.width + width) }
	public func adding(height: CGFloat) -> CGRect { return self.changing(height: self.height + height) }
    public func adding(size: CGSize) -> CGRect {
        return CGRect(x: self.minX, y: self.minY, width: self.width + size.width, height: self.height + size.height)
    }
    public func adding(position: CGPoint) -> CGRect {
        return CGRect(x: self.minX + position.x, y: self.minY + position.y, width: self.width, height: self.height)
    }
	
    public func removing(x: CGFloat) -> CGRect { return self.adding(x: -x) }
    public func removing(y: CGFloat) -> CGRect { return self.adding(y: -y) }
    public func removing(width: CGFloat) -> CGRect { return self.adding(width: -width) }
    public func removing(height: CGFloat) -> CGRect { return self.adding(height: -height) }
    public func removing(size: CGSize) -> CGRect {
        return self.adding(size: CGSize(width: -size.width, height: -size.height))
    }
    public func removing(position: CGPoint) -> CGRect {
        return self.adding(position: CGPoint(x: -position.x, y: -position.y))
    }
	
	public init(center: CGPoint, size: CGSize) {
		self.init(x: center.x - size.width/2, y: center.y - size.height/2, width: size.width, height: size.height)
	}
}

extension UIEdgeInsets {
	public func changing(top: CGFloat) -> UIEdgeInsets { return UIEdgeInsets(top: top, left: self.left, bottom: self.bottom, right: self.right) }
	public func changing(left: CGFloat) -> UIEdgeInsets { return UIEdgeInsets(top: self.top, left: left, bottom: self.bottom, right: self.right) }
	public func changing(bottom: CGFloat) -> UIEdgeInsets { return UIEdgeInsets(top: self.top, left: self.left, bottom: bottom, right: self.right) }
	public func changing(right: CGFloat) -> UIEdgeInsets { return UIEdgeInsets(top: self.top, left: self.left, bottom: self.bottom, right: right) }
}

extension UIView {
	/// The size of the intersection between the caller and the view in parameter
	/// the visual intersection is independent from the view hierarchy.
	/// note: the view in parameter is optional for convenience
	/// warning: DON'T USE THIS METHOD IN VIEWDIDLOAD, because view are not sized properly
	/// at this time.
	public func size(ofIntersectionWith view: UIView?) -> CGSize {
		guard let view = view else { return .zero }
		let myRect = self.convert(bounds, to: nil)
		let hisRect = view.convert(view.bounds, to: nil)
		if myRect.intersects(hisRect) {
			return myRect.intersection(hisRect).size
		}
		else {
			return .zero
		}
	}
}

