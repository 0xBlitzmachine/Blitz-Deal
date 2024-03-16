//
//  StoreView.swift
//  Blitz-Deal
//
//  Created by Viktor Schäfer on 15.03.24.
//

import SwiftUI

struct StoreView: View {
    @EnvironmentObject private var storeObjectHandler: StoreObjectHandler
    
    var body: some View {
        ScrollView {
            ForEach(self.storeObjectHandler.storeObjects.sorted(by: { Int($0.storeID!)! < Int($1.storeID!)! }), id: \.storeID) { storeObject in
                
                VStack {
                    AsyncImage(url: storeObject.images?.banner) { phase in
                        switch phase {
                        case .empty:
                            ProgressView()
                        case .success(let image):
                            image
                                .aspectRatio(contentMode: .fit)
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
                    .frame(height: 80)
                    .frame(maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/)
                    .background {
                        LinearGradient(colors: [.black, .gray],
                                       startPoint: .top,
                                       endPoint: .bottom)
                    }
                    .padding()
                }
                
                DealGameView(storeID: Int(storeObject.storeID!)!)
                
                Divider()
                    .padding()
            }
        }
        .scrollIndicators(.hidden)
    }
}

#Preview {
    StoreView()
        .environmentObject(StoreObjectHandler.shared)
}
