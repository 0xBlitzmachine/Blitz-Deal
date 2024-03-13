//
//  ContentView.swift
//  Blitz-Deal
//
//  Created by Viktor Schäfer on 15.01.24.
//

import SwiftUI
import SSToastMessage

struct ContentView: View {
    
    @StateObject private var storeObjectHandler: StoreObjectsHandler = .shared
    
    @State private var showNotification = false
    
    var body: some View {
        if self.storeObjectHandler.dataLoaded {
            TabView {
                List {
                    ForEach(self.storeObjectHandler.storeObjects, id: \.storeID) { storeObject in
                        Text(storeObject.storeName!)
                    }
                    .onDelete(perform: { indexSet in
                        let object = self.storeObjectHandler.rawStoreObjects[indexSet.first!]
                        self.storeObjectHandler.deleteObject(object: object)
                    })
                    
                }
                .tabItem {
                    Label("Tab 1", systemImage: "person")
                }
                .tag(1)
                
                VStack {
                    Button("Show Notification") {
                        showNotification.toggle()
                    }
                    .buttonStyle(.borderedProminent)
                }
                .tabItem {
                    Label("Tab 2", systemImage: "person")
                }
                .tag(2)
                
                Text("Lala")
                    .tabItem {
                        Label("Tab 3", systemImage: "person")
                    }
                    .tag(3)
            }
            .present(isPresented: $showNotification,
                     type: .floater(verticalPadding: 60),
                     position: .top,
                     autohideDuration: 2, view: {
                NotificationView(notificationType: .success,
                                 notificationMessage: "This is my custom notification Message and so on. Whatever it was, it was successful!")
            })
        } else {
            SplashScreenView()
                .environmentObject(storeObjectHandler)
        }
    }
}

#Preview {
    ContentView()
        .environmentObject(StoreObjectsHandler.shared)
}
