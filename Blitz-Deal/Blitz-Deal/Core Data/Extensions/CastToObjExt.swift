//
//  ModelConverter.swift
//  Blitz-Deal
//
//  Created by Viktor Schäfer on 28.02.24.
//

import Foundation
import CoreData


extension Array where Element == StoreObject {
    func castToCheapSharkObjectArray() -> [CSStoreObject] {
        self.map { storeObject in
            storeObject.castToCheapSharkObject()
        }
    }
}

extension StoreObject {
    func castToCheapSharkObject() -> CSStoreObject {
        return CSStoreObject(storeID: self.storeID,
                                     storeName: self.storeName,
                                     isActive: self.isActive ? 1 : 0,
                                     images: CSStoreImages(banner: self.images?.banner,
                                                                  logo: self.images?.logo,
                                                                  icon: self.images?.icon))
    }
}


extension CSStoreObject {
    func castToStoreObject(context: NSManagedObjectContext) {
        let storeObject: StoreObject = .init(context: context)
        
        storeObject.storeID = self.storeID
        storeObject.storeName = self.storeName
        storeObject.isActive = self.isStoreActive
        storeObject.images = self.images?.castToStoreImage(context: context)
    }
}

extension CSStoreImages {
    func castToStoreImage(context: NSManagedObjectContext) -> StoreImage {
        let storeImage: StoreImage = .init(context: context)
        
        storeImage.banner = self.banner?.absoluteString
        storeImage.logo = self.logo?.absoluteString
        storeImage.icon = self.icon?.absoluteString
        return storeImage
    }
}
