//
//  WeatherTests.swift
//  MeteoAppTests
//
//  Created by Martin Prot on 10/08/2019.
//  Copyright © 2019 appricot media. All rights reserved.
//

import XCTest
import MPModelKit
@testable import MeteoApp

class WeatherTests: XCTestCase {

    var city: City!

    override func setUp() {

        do {
            let dataStore = try CoreDataManager(modelName: "MeteoApp")
            let vm = CitiesViewModel(dataStore: dataStore)
            vm.fetchPredefinedCities { result in
                guard case .success(let cities) = result else { return XCTFail() }

                self.city = cities.first(where: {
                    $0.name == "Nantes"
                })
            }
        }
        catch {
            XCTFail()
        }
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testWeatherFetch() {
        let expectation = self.expectation(description: "Weather API call")
        let vm = WeatherViewModel(city: self.city)
        vm.fetchMeteo { result in
            switch result {
            case .failure(let error): XCTAssert(false, "error while fetching meteo: \(error)")
            case .success(let data):
                XCTAssert(true)
                expectation.fulfill()
            }
        }
        wait(for: [expectation], timeout: 10)
    }

}
