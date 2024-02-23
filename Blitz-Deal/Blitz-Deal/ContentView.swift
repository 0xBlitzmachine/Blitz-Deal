//
//  ContentView.swift
//  Blitz-Deal
//
//  Created by Viktor Schäfer on 15.01.24.
//

import SwiftUI

struct ContentView: View {
    @State private var shopItems: [ShopEntityAPI]? = nil
    @State private var showProgressView = false
    
    var body: some View {
        VStack {
            List {
                if $showProgressView.wrappedValue {
                    ProgressView(label: {
                        Label("Test", systemImage: "person")
                    })
                } else {
                    if let shopItems = shopItems {
                        ForEach(shopItems, id: \.storeID) { shopItem in
                            Text(shopItem.storeName ?? "Error")
                        }
                    }
                }
            }
            
            Button("Fetch") {
                Task {
                    showProgressView = true
                    shopItems = try await ApiManager.getData(dataType: .storesInfo)
                    try await Task.sleep(nanoseconds: 2 * 1000000000)
                    showProgressView = false
                }
            }
        }
    }
}

#Preview {
    ContentView()
}
