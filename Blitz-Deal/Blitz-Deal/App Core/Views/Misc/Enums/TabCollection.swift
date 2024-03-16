//
//  TabCollection.swift
//  Blitz-Deal
//
//  Created by Viktor Schäfer on 16.03.24.
//

import Foundation

enum TabCollection: String {
    case stores, games
    
    var title: String {
        switch self {
        case .stores: return "Stores"
        case .games: return "Games"
        }
    }
    
    var icon: String {
        switch self {
        case .stores: return "storefront.fill"
        case .games: return "gamecontroller.fill"
        }
    }
}
