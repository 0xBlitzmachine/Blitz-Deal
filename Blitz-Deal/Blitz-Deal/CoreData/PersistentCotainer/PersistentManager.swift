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
    
    // CoreData StoreInformation Container
    private let container: NSPersistentContainer
    private let context: NSManagedObjectContext
    
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
    func fetchDataIntoContext() async -> [ShopInfo]? {
        do {
            return try context.fetch(ShopInfo.fetchRequest())
        } catch let error as NSError {
            print("## CORE DATA: Fetching data failed ##")
            print(error.localizedDescription)
            return nil
        }
    }
    
    // Try to save changes on Entities in our Memory to PersistentStore
    func saveContextChanges() {
        do {
            try context.save()
        } catch let error as NSError {
            print("## CORE DATA: Saving Context failed ##")
            print(error.localizedDescription)
        }
    }
}
