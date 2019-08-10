//
//  OpenWeatherAPIConfiguration.swift
//  MeteoApp
//
//  Created by Martin Prot on 10/08/2019.
//  Copyright © 2019 appricot media. All rights reserved.
//

import MPModelKit

public extension BackendConfiguration {

    static let openWeatherBaseURL = URL(string: "https://samples.openweathermap.org/data/2.5")!
    static let openWeatherApiKey = "b6907d289e10d714a6e88b30761fae22"

    static var openWeather: BackendConfiguration {
    return BackendConfiguration(baseURL: openWeatherBaseURL)
    }
}

