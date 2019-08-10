//
//  CitiesViewModel.swift
//  MeteoApp
//
//  Created by Martin Prot on 10/08/2019.
//  Copyright © 2019 appricot media. All rights reserved.
//

import Foundation
import MPModelKit

final class CitiesViewModel: FetchViewModel<City> {

    private var weathers: [IndexPath: Weather] = [:]

    func cityName(at ip: IndexPath) -> String? {
        return self.object(at: ip)?.name
    }

    func fetchPredefinedCities(completion: (Result<[City], Error>) -> Void) {
        guard let jsonPath = Bundle.main.path(forResource: "predefinedCities", ofType: "json") else {
            completion(.failure(VMError.fileNotFound))
            return
        }
        do {
            let jsonData = try Data(contentsOf: URL(fileURLWithPath: jsonPath))
            let jsonObject = try JSONSerialization.jsonObject(with: jsonData, options: [])
            let cities: [City] = try self.dataStore.getInMain { moc in
                return try ArrayResponseMapper.process(obj: jsonObject, objectContext: moc, mapper: CityResponseMapper.process)
            }
            self.dataStore.saveMainContext()
            completion(.success(cities))
        }
        catch {
            completion(.failure(error))
        }
    }

    func weather(at indexPath: IndexPath, completion: @escaping (Result<Weather, Error>) -> Void) {
        // Try the cached weather
        if let weather = self.weathers[indexPath] {
            completion(.success(weather))
            return
        }
        // If not cached, download it
        guard let city = self.object(at: indexPath) else {
            completion(.failure(VMError.objectNotFound))
            return
        }
        let vm = WeatherViewModel(city: city)
        vm.fetchMeteo { [weak self] result in
            if case .success(let weather) = result {
                self?.weathers[indexPath] = weather
            }
            completion(result)
        }
    }
}

extension CitiesViewModel {
    enum VMError: Error {
        case fileNotFound
        case objectNotFound
    }
}
