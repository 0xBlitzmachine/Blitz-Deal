//
//  ModelConverter.swift
//  Blitz-Deal
//
//  Created by Viktor Schäfer on 28.02.24.
//

import Foundation
import CoreData


extension Array where Element == StoreObject {
    func castToCheapSharkObjectArray() -> [CheapSharkStoreObject] {
        self.map { storeObject in
            storeObject.castToCheapSharkObject()
        }
    }
}

extension StoreObject {
    func castToCheapSharkObject() -> CheapSharkStoreObject {
        return CheapSharkStoreObject(storeID: self.storeID,
                                     storeName: self.storeName,
                                     isActive: self.isActive ? 1 : 0,
                                     images: CheapSharkStoreImage(banner: self.images?.banner,
                                                                  logo: self.images?.logo,
                                                                  icon: self.images?.icon))
    }
}


extension CheapSharkStoreObject {
    func castToStoreObject(context: NSManagedObjectContext) {
        let storeObject: StoreObject = .init(context: context)
        
        storeObject.storeID = self.storeID
        storeObject.storeName = self.storeName
        storeObject.isActive = self.isStoreActive
        storeObject.images = self.images?.castToStoreImage(context: context)
    }
}

extension CheapSharkStoreImage {
    func castToStoreImage(context: NSManagedObjectContext) -> StoreImage {
        let storeImage: StoreImage = .init(context: context)
        
        storeImage.banner = self.banner
        storeImage.logo = self.logo
        storeImage.icon = self.icon
        return storeImage
    }
}
