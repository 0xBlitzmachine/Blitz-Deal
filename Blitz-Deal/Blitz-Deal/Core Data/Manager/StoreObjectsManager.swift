//
//  EntityManager.swift
//  Blitz-Deal
//
//  Created by Viktor Schäfer on 26.02.24.
//

import Foundation
import CoreData


class StoreObjectsManager : ObjectManager {
    private let persistentStoreManager: PersistentStoreManager = .singletonInstance
    
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
    static let singletonInstance: StoreObjectsManager = .init()
}

/*
extension StoreObjectsManager {
    private func validateLocalDataAvailability() async {
        var data: [CheapSharkStoreObject]?
        
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

*/


