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
    private var _banner: String?
    private var _logo: String?
    private var _icon: String?
    
    
    var banner: String? {
        get { return self._banner }
        set { self._banner = newValue != nil ? CheapSharkStoreImage.baseUrl + newValue! : nil }
    }
    
    var logo: String? {
        get { return self._logo }
        set { self._logo = newValue != nil ? CheapSharkStoreImage.baseUrl + newValue! : nil }
    }
    var icon: String? {
        get { return self._icon }
        set { self._icon = newValue != nil ? CheapSharkStoreImage.baseUrl + newValue! : nil }
    }
    
}

extension CheapSharkStoreImage {
    static private let baseUrl: String = "https://cheapshark.com"
}
