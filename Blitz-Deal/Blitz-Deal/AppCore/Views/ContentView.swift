//
//  ContentView.swift
//  Blitz-Deal
//
//  Created by Viktor Schäfer on 15.01.24.
//

import SwiftUI

struct ContentView: View {
    @StateObject private var entityManager: EntityManager = .shared
    
    var body: some View {
        VStack {
            List {
                ForEach(self.entityManager.storeEntities, id: \.storeID) { storeEntity in
                    VStack {
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
        .environmentObject(EntityManager.shared)
}
