//
//  EntityManager.swift
//  Blitz-Deal
//
//  Created by Viktor Schäfer on 26.02.24.
//

import Foundation
import CoreData


class StoreObjectsManager {
    private let persistentStoreManager: PersistentStoreManager = .shared
    
    var context: NSManagedObjectContext {
        return self.persistentStoreManager.context
    }
    
    func fetchIntoContext(_ completion: @escaping (Result<[StoreObject], Error>) -> Void) {
        do {
            let objects = try self.persistentStoreManager.context.fetch(StoreObject.fetchRequest())
            completion(.success(objects))
        } catch {
            completion(.failure(error))
        }
    }
    
    func saveContext() {
        guard self.persistentStoreManager.context.hasChanges else { return }
        
        do {
            try self.persistentStoreManager.context.save()
        } catch {
            print(error.localizedDescription)
        }
    }
}

extension StoreObjectsManager {
    static let shared: StoreObjectsManager = .init()
}


