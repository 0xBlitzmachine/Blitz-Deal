//
//  ContentView.swift
//  Blitz-Deal
//
//  Created by Viktor Schäfer on 15.01.24.
//

import SwiftUI

struct ContentView: View {
    @StateObject private var entityManager: StoreObjectsManager = .shared
    
    var body: some View {
        VStack {
            List {
                // Store View: Sort by User - SortedBy: IsActive - storeName
                ForEach(self.entityManager.storeEntities.sorted(by: { Int($0.storeID!)! < Int($1.storeID!)! }), id: \.storeID) { storeEntity in
                    VStack {
                        AsyncImage(url: URL(string: storeEntity))
                        
                        Text(storeEntity.storeName ?? "Error")
                        Text(storeEntity.storeID ?? "-1")
                        Text(storeEntity.isActive?.description ?? "-1")
                    }
                    .frame(maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/)
                   
                }
                .onDelete(perform: { indexSet in
                    let entity = self.entityManager.rawStoreEntities[indexSet.first!]
                    self.entityManager.deleteEntity(entity: entity)
                })
            }
            
            Button("Delete records") {
                self.entityManager.rawStoreEntities.forEach { shopInfo in
                    self.entityManager.deleteEntity(entity: shopInfo)
                }
            }
        }
    }
}

#Preview {
    ContentView()
        .environmentObject(StoreObjectsManager.shared)
}
