//
//  ContentView.swift
//  Blitz-Deal
//
//  Created by Viktor Schäfer on 15.01.24.
//

import SwiftUI

struct ContentView: View {
    @StateObject private var storeObjectHandler: StoreObjectsHandler = .singletonInstance
    
    var body: some View {
        VStack {
            List {
                ForEach(self.storeObjectHandler.storeObjects.sorted(by: {
                    Int($0.storeID!)! < Int($1.storeID!)!
                }), id: \.storeID) { object in
                    HStack {
                        Text(object.storeName!)
                        Text(object.isStoreActive.description)
                    }
                }
                .onDelete(perform: { indexSet in
                    let object = self.storeObjectHandler.rawStoreObjects[indexSet.first!]
                    self.storeObjectHandler.deleteObject(object: object)
                })
            }
        }
    }
}

#Preview {
    ContentView()
        .environmentObject(StoreObjectsHandler.singletonInstance)
}
