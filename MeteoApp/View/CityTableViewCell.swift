//
//  CityTableViewCell.swift
//  MeteoApp
//
//  Created by Martin Prot on 10/08/2019.
//  Copyright © 2019 appricot media. All rights reserved.
//

import UIKit
import Reusable

class CityTableViewCell: UITableViewCell, WeatherImageLoadable, NibReusable {
    static let height: CGFloat = 100

    @IBOutlet var nameLabel: UILabel?
    @IBOutlet var weatherLabel: UILabel?
    @IBOutlet var weatherImage: UIImageView?
    @IBOutlet var loader: UIActivityIndicatorView?

    override func prepareForReuse() {
        super.prepareForReuse()
        weatherLabel?.text = nil
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
}
