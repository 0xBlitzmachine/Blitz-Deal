//
//  ContentView.swift
//  Blitz-Deal
//
//  Created by Viktor Schäfer on 15.01.24.
//

import SwiftUI

struct ContentView: View {
    @State private var shopItems: [ShopEntityAPI]? = nil
    
    var body: some View {
        VStack {
            List {
                if let shopItems = shopItems {
                    ForEach(shopItems, id: \.storeID) { shopItem in
                        Text(shopItem.storeName ?? "Error")
                    }
                }
            }
            .onAppear {
                Task {
                    shopItems = try await ApiManager.getData(dataType: .storesInfo)
                }
            }
        }
    }
}

#Preview {
    ContentView()
}
