//
//  StoresView.swift
//  Blitz-Deal
//
//  Created by Viktor Schäfer on 20.03.24.
//

import SwiftUI

struct StoresView: View {
    @EnvironmentObject private var storeObjectHandler: StoreObjectHandler
    private let flexibleColumn = [
            GridItem(.flexible(minimum: 150, maximum: 200)),
            GridItem(.flexible(minimum: 100, maximum: 200))

        ]
    
    var body: some View {
        NavigationStack {
            ScrollView {
                Text("Select a store to see his game deals")
                LazyVGrid(columns: flexibleColumn, content: {
                    ForEach(storeObjectHandler.storeObjects, id: \.storeID ) { storeObj in
                        StoreRow(obj: storeObj)
                            .padding()
                    }
                })
            }
            .navigationTitle("Stores")
        }
    }
}

#Preview {
    StoresView()
        .environmentObject(StoreObjectHandler.shared)
}
