//
//  ShopEntityAPI.swift
//  Blitz-Deal
//
//  Created by Viktor Schäfer on 22.02.24.
//

import Foundation

struct CSStoreObject: Codable {
    var storeID: String?
    var storeName: String?
    
    private var isActive: Int?
    var images: CSStoreImages?
    
    init(storeID: String?, storeName: String?, isActive: Int?, images: CSStoreImages?) {
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

struct CSStoreImages: Codable {
    var banner: URL?
    var logo: URL?
    var icon: URL?
    
    init(banner: String?, logo: String?, icon: String?) {
        let url = "https://cheapshark.com"
        
        if let banner { self.banner = URL(string: url + banner) }
        if let logo { self.logo = URL(string: url + logo) }
        if let icon { self.icon = URL(string: url + icon) }
    }
}
