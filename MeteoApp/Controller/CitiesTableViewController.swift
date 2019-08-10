//
//  CitiesTableViewController.swift
//  MeteoApp
//
//  Created by Martin Prot on 10/08/2019.
//  Copyright © 2019 appricot media. All rights reserved.
//

import UIKit
import Reusable

protocol CitiesTableViewControllerDelegate: class {
    func controller(_ controller: CitiesTableViewController, didSelect city: City)
}

class CitiesTableViewController: UITableViewController {

    let viewModel: CitiesViewModel

    weak var delegate: CitiesTableViewControllerDelegate?

    init(viewModel: CitiesViewModel) {
        self.viewModel = viewModel
        super.init(style: .plain)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        self.tableView.rowHeight = CityTableViewCell.height
        self.tableView.register(cellType: CityTableViewCell.self)
        self.title = "Cities"
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return self.viewModel.sectionCount
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.viewModel.itemCount(atSection: section)
    }


    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: CityTableViewCell = tableView.dequeueReusableCell(for: indexPath)
        cell.nameLabel?.text = self.viewModel.cityName(at: indexPath)
        return cell
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        guard let city = self.viewModel.object(at: indexPath) else { return }
        self.delegate?.controller(self, didSelect: city)
    }
}
