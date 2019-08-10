//
//  CurrentWeatherAPIRequest.swift
//  MeteoApp
//
//  Created by Martin Prot on 10/08/2019.
//  Copyright © 2019 appricot media. All rights reserved.
//

import MPModelKit

struct CurrentWeatherAPIRequest: BackendAPIObjectRequest {

    let cityName: String
    let countryCode: String?
    let token: String

    /// Defines the api endpoint to use
    let endpoint: String = "forecast"

    // Define what method
    let method: NetworkService.Method = .GET

    // The parameters to pass in
    var parameters: [String: Any]? {
        if let cc = self.countryCode {
            return ["q": "\(self.cityName),\(cc)",
                    "appid": self.token]
        }
        else {
            return ["q": self.cityName,
                    "appid": self.token]
        }
    }
}
