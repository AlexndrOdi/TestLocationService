//
//  Errors.swift
//  TestLocationService
//
//  Created by Alex Odintsov on 02.07.2018.
//  Copyright © 2018 Alex Odintsov. All rights reserved.
//

import Foundation

enum NSKeyedUnarchiverError: Error {
    case unsuccessfulCast
}

enum DecodingDataError: Error {
    case keyNotFound
}
