//
//  ModelConverter.swift
//  Blitz-Deal
//
//  Created by Viktor Schäfer on 28.02.24.
//

import Foundation
import CoreData

extension Array where Element == ShopInfo {
    func toStoreEntityArray() -> [StoreEntityAPI] {
        self.map { shopInfo in
            shopInfo.toStoreEntity()
        }
    }
}

extension ShopInfo {
    func toStoreEntity() -> StoreEntityAPI {
        return StoreEntityAPI(storeID: self.storeID,
                              storeName: self.storeName,
                              isActive: Int(self.isActive),
                              images: StoreEntityImages(banner: self.shopLogos?.banner,
                                                        logo: self.shopLogos?.logo,
                                                        icon: self.shopLogos?.icon))
    }
}

extension StoreEntityAPI {
    func toShopInfo(context: NSManagedObjectContext) {
        let shopInfo = ShopInfo(context: context)
        let shopLogo = ShopLogo(context: context)
        
        shopLogo.banner = self.images?.banner
        shopLogo.logo = self.images?.logo
        shopLogo.icon = self.images?.icon
        
        shopInfo.storeID = self.storeID
        shopInfo.storeName = self.storeName
        shopInfo.isActive = Int16(self.isActive ?? 0)
        shopInfo.shopLogos = shopLogo
    }
}
