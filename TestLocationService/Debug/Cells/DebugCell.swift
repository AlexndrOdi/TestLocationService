//
//  DebugCell.swift
//  TestLocationService
//
//  Created by Alex Odintsov on 19.06.2018.
//  Copyright © 2018 Alex Odintsov. All rights reserved.
//

import UIKit

class DebugCell: UITableViewCell {
    // MARK: - Views
    let nameLabel: UILabel = {
        let label = UILabel()
        label.text = "Some text"
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.boldSystemFont(ofSize: 18)
        return label
    }()

    // MARK: - Init
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setup()

    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Private functions
    private func setup() {
        addSubview(nameLabel)
        addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|-16-[v0]|",
                                                      options: NSLayoutFormatOptions(),
                                                      metrics: nil,
                                                      views: ["v0": nameLabel]))
        addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|[v0]|",
                                                      options: NSLayoutFormatOptions(),
                                                      metrics: nil,
                                                      views: ["v0": nameLabel]))

        accessoryType = .disclosureIndicator
    }
}

extension DebugCell: ReuseIdentifierProtocol {

}
