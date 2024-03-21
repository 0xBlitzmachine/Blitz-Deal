//
//  StoreRow.swift
//  Blitz-Deal
//
//  Created by Viktor Schäfer on 20.03.24.
//

import SwiftUI

struct StoreRow: View {
    let obj: CSStoreObject
    
    var body: some View {
        VStack {
            AsyncImage(url: obj.images?.banner) { phase in
                if let error = phase.error {
                    Image("no_image50x50")
                        .resizable()
                        .padding()
                        .onAppear {
                            print(error.localizedDescription)
                        }
                } else if let image = phase.image {
                    image
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 250)
                        .shadow(color: .black, radius: 2)
                        .padding()
                } else {
                    ProgressView("Loading image ...")
                        .padding()
                }
            }
            .fixedSize()
            
            Divider()
                .padding(.horizontal, 50)
            
            Text(obj.storeName!)
                .padding()
                .font(.title2)
                .fontWeight(.light)
        }
    }
}

#Preview {
    StoreRow(obj: CSStoreObject(storeID: "1",
                                storeName: "Steam",
                                isActive: 1,
                                images: CSStoreImages(banner: "/img/stores/banners/0.png",
                                                      logo: "/img/stores/logos/0.png",
                                                      icon: "/img/stores/icons/0.png")))
}
