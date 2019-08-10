//
//  WeatherTableViewCell.swift
//  MeteoApp
//
//  Created by Martin Prot on 10/08/2019.
//  Copyright © 2019 appricot media. All rights reserved.
//

import UIKit
import Reusable

class WeatherTableViewCell: UITableViewCell, WeatherImageLoadable, NibReusable {
    static let height: CGFloat = 110

    @IBOutlet var weatherLabel: UILabel?
    @IBOutlet var weatherDateLabel: UILabel?
    @IBOutlet var weatherDescription: UILabel?
    @IBOutlet var weatherImage: UIImageView?
    @IBOutlet var loader: UIActivityIndicatorView?

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }


}
