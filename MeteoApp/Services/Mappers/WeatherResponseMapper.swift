//
//  WeatherResponseMapper.swift
//  MeteoApp
//
//  Created by Martin Prot on 10/08/2019.
//  Copyright © 2019 appricot media. All rights reserved.
//

import MPModelKit

extension Weather: Mappable { }

class WeatherResponseMapper: ClassicResponseMapper<Weather> {

    enum Key: String, ServiceKey {
        case weather = "weather"
        case mainWeather = "main"
        case weatherDescription = "description"
        case weatherIconName = "icon"
    }

    static func process(jsonObject: Any) throws -> Weather {
        guard
            let json = jsonObject as? [String: Any],
            let rawWeathers: [[String: Any]] = json.key(Key.weather),
            let rawWeather = rawWeathers.first,
            let mainWeather: String = rawWeather.key(Key.mainWeather),
            let weatherDescription: String = rawWeather.key(Key.weatherDescription),
            let weatherIconName: String = rawWeather.key(Key.weatherIconName)
            else {
                throw ResponseMapperError.missingAttribute
        }
        return Weather(main: mainWeather, description: weatherDescription, icon: weatherIconName)
    }
}
