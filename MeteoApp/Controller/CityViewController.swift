//
//  CityViewController.swift
//  MeteoApp
//
//  Created by Martin Prot on 10/08/2019.
//  Copyright © 2019 appricot media. All rights reserved.
//

import UIKit
import Reusable

class CityViewController: UIViewController {

    @IBOutlet var tableView: UITableView?

    let viewModel: WeatherViewModel

    init(viewModel: WeatherViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)

    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = self.viewModel.city.name
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .refresh, target: self, action: #selector(onReload(_:)))

        self.tableView?.register(cellType: WeatherTableViewCell.self)
        self.tableView?.rowHeight = WeatherTableViewCell.height
        self.tableView?.allowsSelection = false

        self.viewModel.fetchForecast { _ in
            self.tableView?.reloadData()
        }
    }

    @objc func onReload(_ sender: UIBarButtonItem) {
        self.viewModel.fetchForecast { _ in
            self.tableView?.reloadData()
        }
    }
}

extension CityViewController: UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.viewModel.forecast.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: WeatherTableViewCell = tableView.dequeueReusableCell(for: indexPath)
        let weather = self.viewModel.forecast[indexPath.row]
        cell.loadImage(weather: weather)

        let dateFormatter = DateFormatter()
        dateFormatter.doesRelativeDateFormatting = true
        dateFormatter.dateStyle = .short
        dateFormatter.timeStyle = .short
        cell.weatherDateLabel?.text = dateFormatter.string(from: weather.date)
        cell.weatherLabel?.text = weather.main
        cell.weatherDescription?.text = weather.description
        return cell
    }
}
