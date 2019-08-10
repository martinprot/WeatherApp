//
//  CityTableViewCell.swift
//  MeteoApp
//
//  Created by Martin Prot on 10/08/2019.
//  Copyright © 2019 appricot media. All rights reserved.
//

import UIKit
import Reusable

class CityTableViewCell: UITableViewCell, NibReusable {
    static let height: CGFloat = 100

    @IBOutlet var nameLabel: UILabel?
    @IBOutlet var weatherImage: UIImageView?

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
}
