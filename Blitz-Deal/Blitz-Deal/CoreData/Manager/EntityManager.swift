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
        
        Task {
            await self.validateLocalDataAvailability()
        }
    }
}

extension EntityManager {
    private func saveContext() {
        if self.persistentManager.context.hasChanges {
            do {
                try self.persistentManager.context.save()
                self.fetchIntoContext()
            } catch let error as NSError {
                print("CoreData - SaveContext: " + error.localizedDescription)
            }
        }
    }
    
    private func fetchIntoContext() {
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
    private func validateLocalDataAvailability() async {
        
        // MARK: Test list for testing function
        /*
         var data: [StoreEntityAPI] {
             [
                StoreEntityAPI(storeID: "1", storeName: "Blitz", isActive: 3, images: StoreEntityImages(banner: "banner", logo: "logo", icon: "icon"))
             ]
         }
         */
         
        var data: [StoreEntityAPI]?
        
        do {
            data = try await CheapSharkService.getData(.storesInfo)
        } catch {
            print(error.localizedDescription)
        }
        
        guard let data = data else { return }
        
        if self.rawStoreEntities.isEmpty {
            data.forEach { storeEntity in
                self.createEntity(entity: storeEntity)
            }
            
        } else {
            data.forEach { storeEntity in
                guard let entity = self.rawStoreEntities.first(where: { $0.storeID == storeEntity.storeID}) else {
                    print("\(storeEntity.storeName!) was not in the List! Adding it!")
                    self.createEntity(entity: storeEntity)
                    return
                }
                
                if let storeName = storeEntity.storeName, let shopName = entity.storeName {
                    if storeName != shopName {
                        print("CoreData Shopname: \(shopName) - But API Shopname: \(storeName)")
                        entity.storeName = storeName
                    }
                }
                
                if let storeIsActive = storeEntity.isActive, let shopIsActive = Int16(exactly: entity.isActive) {
                    if storeIsActive != Int(shopIsActive) {
                        print("CoreData isActive: \(shopIsActive) - But API isActive: \(storeIsActive)")
                        entity.isActive = Int16(storeIsActive)
                    }
                }
                
                if let storeImages = storeEntity.images, let shopImages = entity.shopLogos {
                    if let storeBanner = storeImages.banner, let shopBanner = shopImages.banner {
                        if storeBanner != shopBanner {
                            print("CoreData Banner: \(shopBanner) - But API Banner: \(storeBanner)")
                            entity.shopLogos?.banner = storeBanner
                        }
                    }
                    
                    if let storeLogo = storeImages.logo, let shopLogo = shopImages.logo {
                        if storeLogo != shopLogo {
                            print("CoreData Logo: \(shopLogo) - But API Logo: \(storeLogo)")
                            entity.shopLogos?.logo = storeLogo
                        }
                    }
                    
                    if let storeIcon = storeImages.icon, let shopIcon = shopImages.icon {
                        if storeIcon != shopIcon {
                            print("CoreData Icon: \(shopIcon) - But API Icon: \(storeIcon)")
                            entity.shopLogos?.banner = storeIcon
                        }
                    }
                }
            }
            self.saveContext()
        }
    }
}



