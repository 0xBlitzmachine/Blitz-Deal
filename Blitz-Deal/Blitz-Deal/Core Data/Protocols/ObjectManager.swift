//
//  StoreObjectManagerProtocol.swift
//  Blitz-Deal
//
//  Created by Viktor Schäfer on 29.02.24.
//

import Foundation
import CoreData

protocol ObjectManager {
    func fetchIntoContext(_ completion: @escaping (Result<[StoreObject], Error>) -> Void)
    func saveContext()
}
