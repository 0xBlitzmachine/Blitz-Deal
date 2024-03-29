//
//  TabCollection.swift
//  Blitz-Deal
//
//  Created by Viktor Schäfer on 16.03.24.
//

import Foundation

enum TabCollection: String {
    case deals, stores
    
    var title: String {
        switch self {
        case .deals: return "Deals"
        case .stores: return "Stores"
        }
    }
    
    var icon: String {
        switch self {
        case .stores: return "storefront.fill"
        case .deals: return "gamecontroller.fill"
        }
    }
}
