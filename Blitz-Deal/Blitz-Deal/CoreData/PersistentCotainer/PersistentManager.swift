//
//  PersistentManager.swift
//  Blitz-Deal
//
//  Created by Viktor Schäfer on 26.02.24.
//

import Foundation
import CoreData

class PersistentManager {
    
    // Single instance of PersistentManager
    static let shared: PersistentManager = .init()
    
    private let container: NSPersistentContainer
    let context: NSManagedObjectContext
    
    // Load Container by its Modelname and load PersistentStore
    init() {
        container = .init(name: "StoreInformation")
        context = container.viewContext
        container.loadPersistentStores { _, error in
            if let error = error as NSError? {
                fatalError("CoreData" + error.localizedDescription)
            }
        }
    }
    
    // Fetch all Shop Information Entities from the PersistentStore into our Memory
    func fetchDataIntoContext() async throws -> [ShopInfo]? {
        return try context.fetch(ShopInfo.fetchRequest())
    }
    
    // Try to save changes on Entities in our Memory to PersistentStore
    func saveContextChanges() throws {
        try context.save()
    }
}
