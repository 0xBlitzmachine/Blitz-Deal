//
//  EntityManager.swift
//  Blitz-Deal
//
//  Created by Viktor Schäfer on 26.02.24.
//

import Foundation

class EntityManager: ObservableObject {
    // Create single instance of EntityManager
    static let shared: EntityManager = .init()
    
    // Property Wrapper for fetched entities to update the view(s)
    @Published var storeEntities: [ShopInfo]? = .none
    
    // Load entities from PersistentStore into Memory on EntityManager init()
    init() {
        Task {
            self.storeEntities = await PersistentManager.shared.fetchDataIntoContext()
        }
    }
}


// Extensions for Entity Handling
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
            self.saveContextChanges
        }
    }
}

extension EntityManager {
    private func saveContextChanges() async {
        await PersistentManager.shared.saveContextChanges()
        self.storeEntities = await PersistentManager.shared.fetchDataIntoContext()
    }
}
