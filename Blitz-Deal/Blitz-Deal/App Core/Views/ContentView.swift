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
    @State private var gameObj: [CheapSharkGameObject]?
    
    var body: some View {
        if self.storeObjectHandler.dataLoaded {
            TabView {
                List(self.storeObjectHandler.storeObjects, id: \.storeID) { storeObject in
                    VStack {
                        AsyncImage(url: URL(string: (("https://www.cheapshark.com" + (storeObject.images?.logo)!) ?? ""))) { image in
                            image
                                .resizable()
                        } placeholder: {
                            Image(systemName: "person")
                        }
                        
                    }
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
                
                List(gameObj ?? [CheapSharkGameObject](), id: \.gameID) { gameObj in
                    Text(gameObj.title ?? "NO TITLE")
                    Text(gameObj.storeID ?? "NO STORE ID")
                }
                .onAppear {
                    Task {
                        gameObj = try await CheapSharkService.getData(endpoint: .listOfDeals,
                                                                      parameters: "storeID=3")
                    }
                }
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
