//
//  OpenWeatherAPIConfiguration.swift
//  MeteoApp
//
//  Created by Martin Prot on 10/08/2019.
//  Copyright © 2019 appricot media. All rights reserved.
//

import MPModelKit

public extension BackendConfiguration {

    static let openWeatherSampleBaseURL = URL(string: "https://samples.openweathermap.org/data/2.5")!
    static let openWeatherBaseURL = URL(string: "https://openweathermap.org/data/2.5")!
    static let openWeatherApiKey = "b6907d289e10d714a6e88b30761fae22"
    static internal func iconURL(for weather: Weather) -> URL {
        return URL(string: "https://openweathermap.org/img/wn/\(weather.icon)@2x.png")!
    }

    static var openWeather: BackendConfiguration {
        return BackendConfiguration(baseURL: openWeatherBaseURL)
    }
    static var sampleOpenWeather: BackendConfiguration {
        return BackendConfiguration(baseURL: openWeatherSampleBaseURL)
    }
}

