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
            AsyncImage(url: obj.images?.logo) { phase in
                if let error = phase.error {
                    Image("no_image50x50")
                        .onAppear {
                            print(error.localizedDescription)
                        }
                } else if let image = phase.image {
                    image
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(height: 100)
                        .padding()
                } else {
                    ProgressView("Loading image ...")
                }
            }
            .fixedSize()
            
            Text(obj.storeName!)
                .padding()
                .font(.title2)
                .fontWeight(.thin)
        }
        .background {
            RoundedRectangle(cornerRadius: 10)
                .stroke(.gray ,lineWidth: 2)
        }
        .shadow(color: .black,radius: 5)
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
