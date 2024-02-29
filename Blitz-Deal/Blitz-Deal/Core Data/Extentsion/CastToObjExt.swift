//
//  ModelConverter.swift
//  Blitz-Deal
//
//  Created by Viktor Schäfer on 28.02.24.
//

import Foundation
import CoreData

/*
extension Array where Element == StoreObject {
    func castToCheapSharkObjectArray() -> [CheapSharkStoreObject] {
        self.map { storeObject in
            storeObject.castToCheapSharkObject()
        }
    }
}

extension StoreObject {
    func castToCheapSharkObject() -> CheapSharkStoreObject {
        let cheapSharkStoreObject: CheapSharkStoreObject = .
        cheapSharkStoreObject.
    }
}
 */


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
    func castToStoreImage(context: NSManagedObjectContext) {
        let storeImage: StoreImage = .init(context: context)
        
        storeImage.banner = self.banner
        storeImage.logo = self.logo
        storeImage.icon = self.icon
    }
}
