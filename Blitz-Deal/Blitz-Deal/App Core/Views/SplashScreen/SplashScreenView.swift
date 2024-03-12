//
//  SplashScreenView.swift
//  Blitz-Deal
//
//  Created by Viktor Schäfer on 12.03.24.
//

import SwiftUI

struct SplashScreenView: View {
    
    @EnvironmentObject private var storeObjectHandler: StoreObjectsHandler
    
    @State private var imageOpacity: Double = 0.0
    @State private var imageScale: CGSize = .init(width: 0.8, height: 0.8)
    @State private var imageShadowRadius: CGFloat = 0
    
    @State private var readyToLoad: Bool = false
    
    @State private var loadingMessage = String()
    
    var body: some View {
        VStack {
            Image("blitzdeal_banner_trans")
                .resizable()
                .scaledToFit()
                .shadow(radius: self.imageShadowRadius)
                .opacity(self.imageOpacity)
                .scaleEffect(self.imageScale)
                .onAppear {
                    withAnimation(.easeIn(duration: 1.5)) {
                        self.imageScale = CGSize(width: 2, height: 2)
                        self.imageShadowRadius = 2
                        self.imageOpacity = 1
                        
                        DispatchQueue.main.asyncAfter(deadline: .now() + 2.5, execute: {
                            withAnimation {
                                self.readyToLoad.toggle()
                            }
                        })
                    }
                }
            
            if self.readyToLoad {
                VStack {
                    Divider()
                        .padding()
                    
                    ProgressView()
                        .opacity(self.storeObjectHandler.dataLoaded ? 0.0 : 1.0)
                        .padding()
                    
                    Text(self.storeObjectHandler.dataStatusMessage)
                        .font(.system(size: 20))
                        .fontWeight(.thin)
                    
                    Spacer()
                }
                .onAppear {
                    self.storeObjectHandler.dataStatusMessage = "Preparing App .."
                    Task {
                        try await Task.sleep(for: .seconds(1))
                        try await self.storeObjectHandler.validateDatabaseContent()
                    }
                }
            }
        }
        
    }
}


#Preview {
    SplashScreenView()
        .environmentObject(StoreObjectsHandler.shared)
}
