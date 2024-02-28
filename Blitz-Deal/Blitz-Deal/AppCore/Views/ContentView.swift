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
                ForEach(entityManager.storeEntities, id: \.storeName) { storeEntity in
                    Text(storeEntity.storeName ?? "Error")
                }
                .onDelete(perform: { indexSet in
                    let entity = self.entityManager.rawStoreEntities[indexSet.first!]
                    self.entityManager.deleteEntity(entity: entity)
                })
            }
        }
    }
}

#Preview {
    ContentView()
        .environmentObject(EntityManager.shared)
}
