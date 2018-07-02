//
//  ChartsViewController.swift
//  TestLocationService
//
//  Created by Alex Odintsov on 30.06.2018.
//  Copyright © 2018 Alex Odintsov. All rights reserved.
//

import UIKit

protocol ChartsViewInputProtocol: class {
    func displayAllCharts(_ consumptions: [Consumption])
}

protocol ChartsViewOutputProtocol: class {
    func performAllCharts()
}

class ChartsViewController: UITableViewController, ChartsViewInputProtocol {

    // MARK: - Properties
    var presenter: ChartsPresenterProtocol?
    var consumptions: [Consumption] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        ChartsConfigurer.sharedInstance.configure(view: self)
        tableView.register(ChartCell.self, forCellReuseIdentifier: ChartCell.identifier)
        presenter?.performAllCharts()
    }

    // MARK: - Functions
    func displayAllCharts(_ consumptions: [Consumption]) {
        self.consumptions = consumptions
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }

    // MARK: - TableView delegate and dataSource
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return view.bounds.height - 100
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: ChartCell.identifier,
                                                       for: indexPath) as? ChartCell else {
                fatalError("The dequeued cell is not an instance of DescriptionCell")
        }
        cell.chart.delegate = presenter
        cell.updateChart(consumptions)

        return cell
    }
}
