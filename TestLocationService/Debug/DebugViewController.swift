//
//  DebugViewController.swift
//  TestLocationService
//
//  Created by Alex Odintsov on 19.06.2018.
//  Copyright © 2018 Alex Odintsov. All rights reserved.
//

import UIKit

protocol DebugViewOutputProtocol: class {
    func navigateToDebugDetail()
    func passDataToNextScene(segue: UIStoryboardSegue)
}
protocol DebugViewInputProtocol: class {
    
}

class DebugViewController: UITableViewController, DebugViewInputProtocol {

    var presenter: DebugViewOutputProtocol?
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        super.prepare(for: segue, sender: sender)
        
        presenter?.passDataToNextScene(segue: segue)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        DebugConfigurer.sharedInstance.configure(view: self)

        navigationItem.title = Consts.NavigationTitle.Debug.rawValue
        navigationController?.hidesBottomBarWhenPushed = true
        tableView.register(DebugCell.self, forCellReuseIdentifier: DebugCell.identifier)
    }
}

extension DebugViewController {
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 4
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: DebugCell.identifier, for: indexPath) as? DebugCell else {
            fatalError("The dequeued cell is not an instance of DebugCell")
        }
        
        switch indexPath.row {
        case 0:
            cell.nameLabel.text = Consts.DebugButtons.battary.rawValue
        case 1:
            cell.nameLabel.text = Consts.DebugButtons.location.rawValue
        case 2:
            cell.nameLabel.text = Consts.DebugButtons.numberOfReqests.rawValue
        case 3:
            cell.nameLabel.text = Consts.DebugButtons.something.rawValue
        default:
            fatalError("Cell presentation not found.")
        }
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60.0
    }
    
    override func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        return UIView()
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        presenter?.navigateToDebugDetail()
    }
}
