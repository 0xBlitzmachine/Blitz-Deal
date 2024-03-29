//
//  SplashScreenView.swift
//  Blitz-Deal
//
//  Created by Viktor Schäfer on 12.03.24.
//

import SwiftUI

struct SplashScreenView: View {
    
    @EnvironmentObject private var storeObjectHandler: StoreObjectHandler
    
    @State private var imageOpacity: Double = 0.0
    @State private var imageScale: CGSize = .init(width: 0.8, height: 0.8)
    @State private var imageShadowRadius: CGFloat = 0
    @State private var imageCopyrightScale: CGSize = .init(width: 1, height: 1)
    
    @State private var stackOpacity: Double = 1.0
    
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
            
            Text("Logo by Ali Aksoy")
                .font(.headline)
                .fontWeight(.ultraLight)
                .scaleEffect(imageCopyrightScale)
            
            
            
            if self.readyToLoad {
                VStack {
                    Divider()
                        .padding()
                    
                    ProgressView()
                        .progressViewStyle(.circular)
                        .opacity(self.storeObjectHandler.dataLoaded ? 0.0 : 1.0)
                        .padding()
                        .scaleEffect(CGSize(width: 1.5, height: 1.5))
                    
                    Text(self.storeObjectHandler.dataStatusMessage)
                        .font(.system(size: 25))
                        .fontWeight(.light)
                        .fontWidth(.compressed)
                    
                    Spacer()
                }
                .onAppear {
                    Task {
                        try await self.storeObjectHandler.validateDatabaseContent()
                        
                        withAnimation(.easeOut(duration: 2)) {
                            self.stackOpacity = 0
                            self.imageScale = CGSize(width: 5, height: 5)
                            self.imageOpacity = 0
                            self.imageCopyrightScale = CGSize(width: 3, height: 3)
                        }
                        
                        DispatchQueue.main.asyncAfter(deadline: .now() + 1, execute: {
                            withAnimation {
                                self.storeObjectHandler.validateDataLoaded()
                            }
                        })
                    }
                }
            }
        }
        .opacity(self.stackOpacity)
    }
}


#Preview {
    SplashScreenView()
        .environmentObject(StoreObjectHandler.shared)
}
