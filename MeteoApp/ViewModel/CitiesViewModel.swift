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
}

extension CitiesViewModel {
    enum VMError: Error {
        case fileNotFound
    }
}
