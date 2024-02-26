//
//  CoreDataError.swift
//  Blitz-Deal
//
//  Created by Viktor Schäfer on 26.02.24.
//

import Foundation

enum CoreDataError: Error {
    case saveContext(String)
    case fetchData(String)
    case deleteEntity(String)
}
