//
//  CitiesTests.swift
//  MeteoAppTests
//
//  Created by Martin Prot on 10/08/2019.
//  Copyright © 2019 appricot media. All rights reserved.
//

import XCTest
import MPModelKit
@testable import MeteoApp

class CitiesTests: XCTestCase {

    var dataStore: CoreDataManager?

    override func setUp() {
        self.dataStore = try? CoreDataManager(modelName: "MeteoApp")
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testFetchPredefinedCities() {
        guard let ds = self.dataStore else { return XCTFail() }
        let vm = CitiesViewModel(dataStore: ds)
        vm.fetchPredefinedCities { result in
            switch result {
            case .failure(let error):
                XCTAssert(false, "Failed to get predefined cities: \(error)")
            case .success(let cities):
                XCTAssert(cities.count == 5, "There should be 5 cities. Counting \(cities.count)")
            }
        }
    }

    func testPredefinedCities() {
        // populating the data
        testFetchPredefinedCities()

        guard let ds = self.dataStore else { return XCTFail() }
        let vm = CitiesViewModel(fetchConfiguration: .allCities(on: ds))
        let cityName = vm.cityName(at: IndexPath(row: 1, section: 0))
        XCTAssert(cityName == "Lyon", "The city should be Lyon, not \(cityName ?? "none")")
    }

}
