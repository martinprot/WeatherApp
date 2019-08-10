//
//  UIView+screenshot.swift
//  mpkit
//
//  Created by Martin Prot on 28/03/2018.
//  Copyright © 2018 Appricot media. All rights reserved.
//

import Foundation

extension UIView {

    enum CaptureError: Error {
        case noCurrentContext
        case cannotGenerateImage
    }

    public func capture() throws -> UIImage {
        UIGraphicsBeginImageContextWithOptions(self.bounds.size, false, UIScreen.main.scale)
        guard let context = UIGraphicsGetCurrentContext() else {
            throw CaptureError.noCurrentContext
        }
        self.layer.render(in: context)
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        guard let unwrappedImage = image else {
            throw CaptureError.cannotGenerateImage
        }
        return unwrappedImage
    }

}
