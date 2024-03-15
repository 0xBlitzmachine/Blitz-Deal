//
//  StoreView.swift
//  Blitz-Deal
//
//  Created by Viktor Schäfer on 15.03.24.
//

import SwiftUI

struct StoreView: View {
    @EnvironmentObject private var storeObjectHandler: StoreObjectHandler
    
    var body: some View {
        ScrollView {
            ForEach(storeObjectHandler.storeObjects.sorted(by: { Int($0.storeID!)! < Int($1.storeID!)! }), id: \.storeID) { storeObject in
                AsyncImage(url: storeObject.images?.banner) { image in
                    image
                } placeholder: {
                    Image(systemName: "person")
                }
                
                Text(storeObject.storeID!)

            }
        }
    }
}

#Preview {
    StoreView()
        .environmentObject(StoreObjectHandler.shared)
}
