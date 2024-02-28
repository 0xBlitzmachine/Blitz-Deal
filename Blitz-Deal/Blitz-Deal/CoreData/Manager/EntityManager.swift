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
        
        if rawStoreEntities.isEmpty {
            print("Raw Store Entities was empty! Fetching data from API Service ...")
            Task {
                let apiData: [StoreEntityAPI]? = try await CheapSharkService.getData(.storesInfo)
                print("Data successfully fetched!")
                if let apiData = apiData {
                    print("API Data was not nil! Procceeding ...")
                    apiData.forEach { storeEntity in
                        print("'\(storeEntity.storeName ?? "Error")' - ID: '\(storeEntity.storeID ?? "0")' has been created!")
                        self.createEntity(entity: storeEntity)
                    }
                }
            }
        } else {
            Task {
                let entities: [StoreEntityAPI]? = try await CheapSharkService.getData(.storesInfo)
                if let entities = entities {
                    self.compareStoreEntities(entities)
                }
            }
        }
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
    private func compareStoreEntities(_ entities: [StoreEntityAPI]) {
        Task {
            entities.forEach { entity in
                let shopInfo = self.rawStoreEntities.first(where: { $0.storeID == entity.storeID})
                
                if shopInfo?.storeID != entity.storeID {
                    shopInfo?.storeID = entity.storeID
                }
                
                if shopInfo?.storeName != entity.storeName {
                    shopInfo?.storeName = entity.storeName
                }
                
                if shopInfo?.isActive ?? 0 != entity.isActive ?? 0 {
                    shopInfo?.isActive = Int16(entity.isActive ?? 0)
                }
                
                if shopInfo?.shopLogos?.banner != entity.images?.banner {
                    shopInfo?.shopLogos?.banner = entity.images?.banner
                }
                
                if shopInfo?.shopLogos?.logo != entity.images?.logo {
                    shopInfo?.shopLogos?.logo = entity.images?.logo
                }
                
                if shopInfo?.shopLogos?.icon != entity.images?.icon {
                    shopInfo?.shopLogos?.icon = entity.images?.icon
                }
            }
            self.saveContext()
        }
    }
}



