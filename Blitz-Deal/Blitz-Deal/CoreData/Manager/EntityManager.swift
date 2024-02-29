//
//  EntityManager.swift
//  Blitz-Deal
//
//  Created by Viktor Schäfer on 26.02.24.
//

import Foundation

@MainActor
class EntityManager: ObservableObject {
    
    // Create single instance of EntityManager
    private let persistentManager = PersistentManager.shared
    static let shared: EntityManager = .init()
    
    @Published var storeEntities = [StoreEntityAPI]()
    var rawStoreEntities = [ShopInfo]()
    
    init() {
        self.fetchIntoContext()
        self.validateDataAvailability()
    }
}

extension EntityManager {
    func saveContext() {
        if self.persistentManager.context.hasChanges {
            do {
                try self.persistentManager.context.save()
                self.fetchIntoContext()
            } catch let error as NSError {
                print("CoreData - SaveContext: " + error.localizedDescription)
            }
        }
    }
    
    func fetchIntoContext() {
        do {
            self.rawStoreEntities = try self.persistentManager.context.fetch(ShopInfo.fetchRequest())
            self.storeEntities = self.rawStoreEntities.toStoreEntityArray()
        } catch let error as NSError {
            print("CoreData - FetchIntoContext: " + error.localizedDescription)
        }
    }
    
    func deleteEntity(entity: ShopInfo) {
        self.persistentManager.context.delete(entity)
        self.saveContext()
    }
    
    func createEntity(entity: StoreEntityAPI) {
        entity.toShopInfo(context: self.persistentManager.context)
        self.saveContext()
    }
}

extension EntityManager {
    private func validateDataAvailability() {
        guard rawStoreEntities.isEmpty else { return }
        
        Task {
            let data: [StoreEntityAPI]? = try await CheapSharkService.getData(.storesInfo)
            guard let data = data else { return }
            
            data.forEach { storeEntity in
                storeEntity.toShopInfo(context: self.persistentManager.context)
            }
            self.saveContext()
        }
    }
    
    private func compareStoreEntities(_ entities: [StoreEntityAPI]) {
        
    }
}



