//
//  ContentView.swift
//  Blitz-Deal
//
//  Created by Viktor Schäfer on 15.01.24.
//

import SwiftUI
import SSToastMessage

struct ContentView: View {
    @StateObject private var storeObjectHandler: StoreObjectHandler = .shared
    
    var body: some View {
        NavigationStack {
            if self.storeObjectHandler.dataLoaded {
                MainTabView()
                    .environmentObject(self.storeObjectHandler)
            } else {
                SplashScreenView()
                    .environmentObject(self.storeObjectHandler)
            }
        }
    }
}

#Preview {
    ContentView()
        .environmentObject(StoreObjectHandler.shared)
}
