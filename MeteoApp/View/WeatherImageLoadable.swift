//
//  WeatherImageLoadable.swift
//  MeteoApp
//
//  Created by Martin Prot on 10/08/2019.
//  Copyright © 2019 appricot media. All rights reserved.
//

import Foundation
import ImageLoader

protocol WeatherImageLoadable: class {
    var weatherImage: UIImageView? { get }
    var loader: UIActivityIndicatorView? { get }
}

extension WeatherImageLoadable {
    func loadImage(weather: Weather) {
        self.loader?.startAnimating()
        self.weatherImage?.load.request(with: weather.iconURL, onCompletion: { [weak self] image, _, _ in
            DispatchQueue.main.async {
                self?.weatherImage?.image = image
                self?.loader?.stopAnimating()
            }
        })
    }
}
