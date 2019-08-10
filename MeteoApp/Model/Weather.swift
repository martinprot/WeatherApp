//
//  Weather.swift
//  MeteoApp
//
//  Created by Martin Prot on 10/08/2019.
//  Copyright © 2019 appricot media. All rights reserved.
//

import Foundation
import MPModelKit

struct Weather {
    let date: Date
    let main: String
    let description: String
    let icon: String
}

extension Weather {
    var iconURL: URL {
        return BackendConfiguration.iconURL(for: self)
    }
}
