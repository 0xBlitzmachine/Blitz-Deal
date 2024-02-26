//
//  ShopEntityAPI.swift
//  Blitz-Deal
//
//  Created by Viktor Schäfer on 22.02.24.
//

import Foundation

struct StoreEntityAPI : Codable {
    var storeID: String?
    var storeName: String?
    var isActive: Int?
    var images: StoreEntityImages?
}
