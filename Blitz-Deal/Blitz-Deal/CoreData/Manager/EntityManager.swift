//
//  EntityManager.swift
//  Blitz-Deal
//
//  Created by Viktor Schäfer on 26.02.24.
//

import Foundation

class EntityManager: ObservableObject {
    static let shared: EntityManager = .init()
    
    @Published var storeEntities: [ShopInfo]? = .none
    
    init() {
        
    }
}

extension EntityManager {
    func createEntity(storeID: String?, storeName: String?, isActive: Int?, images: StoreEntityImages?) {
        let storeEntity = ShopInfo.init(context: PersistentManager.shared.context)
        let imagesEntity = ShopLogo.init(context: PersistentManager.shared.context)
        
        imagesEntity.banner = images?.banner
        imagesEntity.logo = images?.logo
        imagesEntity.icon = images?.icon
        
        storeEntity.storeID = storeID
        storeEntity.storeName = storeName
        storeEntity.isActive = Int16(isActive ?? 0)
        storeEntity.shopLogos = imagesEntity
        
        Task {
            try await saveContextChanges() 
        }
    }
}




extension EntityManager {
    private func fetchDataIntoContext() async throws {
        do {
            self.storeEntities = try await PersistentManager.shared.fetchDataIntoContext()
        } catch let error as NSError {
            print("Entity Manager: " + error.localizedDescription)
        }
    }
    
    private func saveContextChanges() async throws {
        do {
            try PersistentManager.shared.saveContextChanges()
            try await self.fetchDataIntoContext()
        } catch let error as NSError {
            print("Entity Manager: " + error.localizedDescription)
        }
    }
}
