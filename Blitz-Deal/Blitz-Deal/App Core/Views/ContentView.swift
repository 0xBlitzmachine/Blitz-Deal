//
//  ContentView.swift
//  Blitz-Deal
//
//  Created by Viktor Schäfer on 15.01.24.
//

import SwiftUI
import SSToastMessage


struct ContentView: View {
    @StateObject private var storeObjectHandler: StoreObjectsHandler = .singletonInstance
    @State private var showNotification = false

    
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
            
            Button("Show Msg") {
                self.showNotification.toggle()
            }
        }
        .present(isPresented: self.$showNotification, type: .floater(verticalPadding: 60), position: .top, autohideDuration: 5.0 ) {
            NotificationView(notificationType: .warning, notificationMessage: "This is a test message!")
                .padding(1)
        }
    }
}

#Preview {
    ContentView()
        .environmentObject(StoreObjectsHandler.singletonInstance)
}
