//
//  CityFetchConfiguration.swift
//  MeteoApp
//
//  Created by Martin Prot on 10/08/2019.
//  Copyright © 2019 appricot media. All rights reserved.
//

import MPModelKit

extension FetchRequestConfiguration {

    /// Creates a fetch configuration to get all tests for the given user
    ///
    /// - Parameters:
    ///   - user: the user available tests
    ///   - dataStore: the datastore to fetch
    /// - Returns: a configuration object
    static func allCities(on dataStore: CoreDataManager) -> FetchRequestConfiguration {
        return FetchRequestConfiguration(dataStore: dataStore,
                                         sortDescriptors: [NSSortDescriptor(key: "name", ascending: true)])
    }
}
