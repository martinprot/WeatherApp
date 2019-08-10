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
        let vm = WeatherViewModel(city: self.city, apiConfiguration: .sampleOpenWeather)
        vm.fetchWeather { result in
            switch result {
            case .failure(let error):
                XCTAssert(false, "error while fetching meteo: \(error)")

            case .success(let weather):
                XCTAssert(weather.date.timeIntervalSince1970 == 1485789600.0, "Weather date be 2017-01-30 15:20:00")
                XCTAssert(weather.main == "Drizzle", "Weather should be Drizzle")
                XCTAssert(weather.description == "light intensity drizzle", "Weather description should be light intensity drizzle")
                XCTAssert(weather.icon == "09d", "Weather icon should be 09d")
            }
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 10)
    }

    func testWeatherForecast() {
        let expectation = self.expectation(description: "Forecast API call")
        let vm = WeatherViewModel(city: self.city, apiConfiguration: .sampleOpenWeather)
        vm.fetchForecast { result in
            switch result {
            case .failure(let error):
                XCTAssert(false, "error while fetching meteo: \(error)")

            case .success(let weathers):
                XCTAssert(weathers.count == 36, "There should be 36 forecasts")
                XCTAssert(weathers[0].main == "Clear", "And the first should be Clear")
            }
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 10)
    }


}
