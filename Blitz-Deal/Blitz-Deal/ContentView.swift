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
            
            if $showProgressView.wrappedValue {
                ProgressView(value: 0.2)
                    .progressViewStyle(.circular)
            } else {
                if let shopItems = shopItems {
                    List {
                        ForEach(shopItems, id: \.storeID) { shopItem in
                            HStack {
                                
                                AsyncImage(url: URL(string: "https://cheapshark.com\(shopItem.images?.banner ?? "")")) { image in
                                    if let image = image.image {
                                        image
                                            .resizable()
                                            .clipped()
                                    }
                                }
                            }
                            
                            
                            Text(shopItem.storeName ?? "Error")
                                .onTapGesture {
                                    print(shopItem.images?.banner)
                                }
                        }
                    }
                }
            }
            
            
            Button("Fetch") {
                Task {
                    showProgressView = true
                    shopItems = try await CheapSharkService.getData(.storesInfo)
                    try await Task.sleep(for: .seconds(3))
                    showProgressView = false
                }
            }
        }
    }
}

#Preview {
    ContentView()
}
