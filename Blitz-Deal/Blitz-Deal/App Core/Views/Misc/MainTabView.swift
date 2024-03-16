//
//  MainTabView.swift
//  Blitz-Deal
//
//  Created by Viktor Schäfer on 15.03.24.
//

import SwiftUI

struct MainTabView: View {
    @EnvironmentObject private var storeObjectHandler: StoreObjectHandler
    
    var body: some View {
        TabView {
            StoreView()
                .tabItem {
                    Label(TabCollection.stores.title,
                          systemImage: TabCollection.stores.icon)
                }
                .tag(TabCollection.stores.rawValue)
                .environmentObject(storeObjectHandler)
            
            // Replace Text View with our new View later!
            Text("")
                .tabItem {
                    Label(TabCollection.games.title,
                          systemImage: TabCollection.games.icon)
                }
                .tag(TabCollection.games.rawValue)
        }
    }
}

#Preview {
    MainTabView()
        .environmentObject(StoreObjectHandler.shared)
}
