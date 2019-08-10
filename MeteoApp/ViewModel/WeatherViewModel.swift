//
//  CityViewModel.swift
//  MeteoApp
//
//  Created by Martin Prot on 10/08/2019.
//  Copyright © 2019 appricot media. All rights reserved.
//

import MPModelKit

final class WeatherViewModel {
    let city: City

    internal init(city: City) {
        self.city = city
    }

    func fetchMeteo(completion: @escaping (Result<Void, Error>) -> Void) {
        guard let cityName = city.name else { return   }

        let service = BackendService(configuration: .openWeather)
        let weatherRequest = CurrentWeatherAPIRequest(cityName: cityName, countryCode: city.countryCode, token: BackendConfiguration.openWeatherApiKey)
        service.fetch(request: weatherRequest, success: { json in

            completion(.success((())))

        }, failure: { _, error, code in

            completion(.failure(error))
        })
    }
    
}
