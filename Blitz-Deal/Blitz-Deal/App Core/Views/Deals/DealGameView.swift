//
//  DealGameView.swift
//  Blitz-Deal
//
//  Created by Viktor Schäfer on 16.03.24.
//

import SwiftUI

struct DealGameView: View {
    @StateObject private var dealGameObjectHandler: DealGameObjectHandler = .init()
    
    let storeID: Int
    
    var body: some View {
        
        if self.dealGameObjectHandler.dataLoaded {
            ForEach(self.dealGameObjectHandler.gameObjects ?? [CSDealGameObject](), id: \.dealID) { dealGameObj in
                HStack {
                    Rectangle()
                        .foregroundStyle(.orange)
                        .frame(width: 10)
                    
                    HStack {
                        AsyncImage(url: dealGameObj.thumb) { phase in
                            switch phase {
                            case .empty:
                                ProgressView()
                            case .success(let image):
                                image
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                                    .frame(width: 50, height: 20)
                            case .failure(let error):
                                Image("no_image100x100")
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                            @unknown default:
                                Image("no_image100x100")
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                                    .background(.white)
                            }
                        }
                        
                        Text(dealGameObj.title!)
                    }
                    .frame(maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/)
                }
            }
        } else {
            ProgressView("Data not loaded - Trying to fetch ...")
                .onAppear {
                    Task {
                        await self.dealGameObjectHandler.fetchGameDeals(storeID: self.storeID,
                                                                        amount: 5,
                                                                        page: 0)
                    }
                }
        }
    }
}

#Preview {
    DealGameView(storeID: 1)
        .environmentObject(DealGameObjectHandler())
}
