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
        NavigationStack {
            TabView {
                DealsView()
                    .tabItem {
                        Label(TabCollection.deals.title,
                              systemImage: TabCollection.deals.icon)
                    }
                    .tag(TabCollection.deals.rawValue)
                    .environmentObject(storeObjectHandler)
                
                // Replace Text View with our new View later!
                StoresView()
                    .tabItem {
                        Label(TabCollection.stores.title,
                              systemImage: TabCollection.stores.icon)
                    }
                    .tag(TabCollection.stores.rawValue)
            }
        }
    }
}

#Preview {
    MainTabView()
        .environmentObject(StoreObjectHandler.shared)
}
