//
//  ReuseIdentifierProtocol.swift
//  TestLocationService
//
//  Created by Alex Odintsov on 19.06.2018.
//  Copyright © 2018 Alex Odintsov. All rights reserved.
//

import UIKit

public protocol ReuseIdentifierProtocol {
    static var identifier: String { get }
}

extension ReuseIdentifierProtocol where Self: UIView {
    static var identifier: String {
        return NSStringFromClass(self).components(separatedBy: ".").last!
    }
}
