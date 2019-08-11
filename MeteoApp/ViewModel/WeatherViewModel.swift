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
    var forecast: [Weather] = []

    internal init(city: City) {
        self.city = city
    }

    /// Fetch current weather for the view model city
    func fetchWeather(completion: @escaping (Result<Weather, Error>) -> Void) {
        guard let cityName = city.name else {
            completion(.failure(VMError.noCityName))
            return
        }

        let service = BackendService(configuration: .openWeather)
        let weatherRequest = CurrentWeatherAPIRequest(cityName: cityName, countryCode: city.countryCode, token: BackendConfiguration.openWeatherApiKey)
        service.fetch(request: weatherRequest, success: { json in
            do {
                let weather = try WeatherResponseMapper.process(jsonObject: json)
                completion(.success(weather))
            }
            catch {
                completion(.failure(error))
            }

        }, failure: { _, error, code in

            completion(.failure(error))
        })
    }

    /// Fetch weather forecast for the view model city
    func fetchForecast(completion: @escaping (Result<[Weather], Error>) -> Void) {
        guard let cityName = city.name else {
            completion(.failure(VMError.noCityName))
            return
        }
        let service = BackendService(configuration: .openWeather)
        let forecastRequest = ForecastAPIRequest(cityName: cityName, countryCode: city.countryCode, token: BackendConfiguration.openWeatherApiKey)
        service.fetch(request: forecastRequest, success: { [weak self] json in
            do {
                let weathers = try ArrayResponseMapper.process(obj: json, mapper: WeatherResponseMapper.process)
                self?.forecast = weathers
                completion(.success(weathers))
            }
            catch {
                completion(.failure(error))
            }

        }, failure: { _, error, code in

            completion(.failure(error))
        })
    }
    
}

extension WeatherViewModel {
    enum VMError: Error {
        case noCityName
    }
}
