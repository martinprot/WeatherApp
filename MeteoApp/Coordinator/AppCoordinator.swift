//
//  AppCoordinator.swift
//  MeteoApp
//
//  Created by Martin Prot on 10/08/2019.
//  Copyright © 2019 appricot media. All rights reserved.
//

import Foundation
import UIKit
import MPModelKit

class AppCoordinator {

    let navigationController: UINavigationController
    let dataManager: CoreDataManager

    init(rootController: UINavigationController = UINavigationController(), dataManager: CoreDataManager) {
        self.navigationController = rootController
        rootController.navigationBar.prefersLargeTitles = true
        self.dataManager = dataManager
    }

    func start() {
        // Creating the cities view controller
        let citiesVM = CitiesViewModel(fetchConfiguration: .allCities(on: self.dataManager))
        citiesVM.fetchPredefinedCities { _ in
            let citiesController = CitiesTableViewController(viewModel: citiesVM)
            citiesController.navigationItem.largeTitleDisplayMode = .never
            citiesController.delegate = self
            self.navigationController.viewControllers = [citiesController]
        }
    }
}

extension AppCoordinator: CitiesTableViewControllerDelegate {
    func controller(_ controller: CitiesTableViewController, didSelect city: City) {
        let meteoVM = WeatherViewModel(city: city)
        let controller = CityViewController(viewModel: meteoVM)
        controller.navigationItem.largeTitleDisplayMode = .always
        self.navigationController.pushViewController(controller, animated: true)

    }
}
