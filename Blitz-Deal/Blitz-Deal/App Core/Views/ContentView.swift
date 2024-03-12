//
//  ContentView.swift
//  Blitz-Deal
//
//  Created by Viktor Schäfer on 15.01.24.
//

import SwiftUI

struct ContentView: View {
    
    @StateObject private var storeObjectHandler: StoreObjectsHandler = .shared
    
    var body: some View {
        if self.storeObjectHandler.dataLoaded {
            Text("Loaded!")
        } else {
            SplashScreenView()
                .environmentObject(storeObjectHandler)
        }
    }
}

#Preview {
    ContentView()
        .environmentObject(StoreObjectsHandler.shared)
}
