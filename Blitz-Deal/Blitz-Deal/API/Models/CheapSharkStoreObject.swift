//
//  ShopEntityAPI.swift
//  Blitz-Deal
//
//  Created by Viktor Schäfer on 22.02.24.
//

import Foundation

struct CheapSharkStoreObject: Codable {
    var storeID: String?
    var storeName: String?
    
    private var isActive: Int?
    var images: CheapSharkStoreImage?
    
    init(storeID: String?, storeName: String?, isActive: Int?, images: CheapSharkStoreImage?) {
        self.storeID = storeID
        self.storeName = storeName
        self.isActive = isActive
        self.images = images
    }
    
    var isStoreActive: Bool {
        switch self.isActive {
        case 0:
            return false
        case 1:
            return true
        default:
            return false
        }
    }
}

struct CheapSharkStoreImage: Codable {
    var banner: String?
    var logo: String?
    var icon: String?
}
