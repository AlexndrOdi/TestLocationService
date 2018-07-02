//
//  DescriptionTableViewController.swift
//  TestLocationService
//
//  Created by Alex Odintsov on 24.06.2018.
//  Copyright © 2018 Alex Odintsov. All rights reserved.
//

import UIKit

protocol DescriptionViewInputProtocol: class {
    func displayInformation(info: [Battery])
}
protocol DescriptionViewOutputProtocol: class {
    func prepareInformation()
}

class DescriptionTableViewController: UITableViewController, DescriptionViewInputProtocol {

    // MARK: - Properties
    var presenter: DescriptionViewOutputProtocol?

    var info: [Battery] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        DescriptionConfigurer.sharedInstance.configure(view: self)

        navigationItem.title = "Some errors"
        tableView.register(DescriptionCell.self, forCellReuseIdentifier: DescriptionCell.identifier)

        presenter?.prepareInformation()
    }

    // MARK: - Functions
    func displayInformation(info: [Battery]) {
        self.info = info
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }

    // MARK: - TableView dataSource and delegate functions
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }

    override func numberOfSections(in tableView: UITableView) -> Int {
        return info.count
    }

    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return section == 0 ? 0 : 10
    }

    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView: UIView = {
            let view = UIView()
            view.backgroundColor = UIColor.lightGray
            return view
        }()
        return headerView
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: DescriptionCell.identifier,
                                                       for: indexPath) as? DescriptionCell else {
            fatalError("The dequeued cell is not an instance of DescriptionCell")
        }

        cell.dateLabel.text = info[indexPath.section].date
        cell.descriptionLabel.text = info[indexPath.section].charge

        return cell
    }
}
