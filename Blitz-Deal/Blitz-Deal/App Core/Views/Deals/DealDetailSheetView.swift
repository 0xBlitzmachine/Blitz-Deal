//
//  DealDetailSheetView.swift
//  Blitz-Deal
//
//  Created by Viktor Schäfer on 21.03.24.
//

import SwiftUI

struct DealDetailSheetView: View {
    
    @EnvironmentObject private var storeObjectHandler: StoreObjectHandler
    @EnvironmentObject private var detailDealObjectHandler: DetailDealObjectHandler
    
    let dealID: String
    
    private var convertedReleaseDate: String {
        if let releaseDate = detailDealObjectHandler.detailedDealObj?.gameInfo.releaseDate {
            return Date(timeIntervalSince1970: TimeInterval(releaseDate)).formatted(date: .complete, time: .omitted)
        } else {
            return "N/A"
        }
    }
    
    var body: some View {
        VStack {
            if detailDealObjectHandler.isDataLoading {
                Image("blitzdeal_banner_trans")
                
                ProgressView("Requesting data ...")
            } else {
                if detailDealObjectHandler.detailedDealObj != nil {
                    AsyncImage(url: detailDealObjectHandler.detailedDealObj?.gameInfo.thumb) { phase in
                        switch phase {
                        case .empty:
                            ProgressView("Loading Image ...")
                        case .success(let image):
                            image
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(height: /*@START_MENU_TOKEN@*/100/*@END_MENU_TOKEN@*/)
                                .border(.black, width: 2)
                                .shadow(color: .black, radius: /*@START_MENU_TOKEN@*/10/*@END_MENU_TOKEN@*/)
                                .padding()
                        case .failure(let error):
                            Image("no_image100x100")
                                .onAppear {
                                    print("DetailView: " + error.localizedDescription)
                                }
                        @unknown default:
                            Image("no_image100x100")
                        }
                    }
                    
                    VStack {
                        HStack {
                            Text("Game Title:")
                                .fontWeight(.thin)
                            
                            Text((detailDealObjectHandler.detailedDealObj?.gameInfo.name!)!)
                                .lineLimit(1)
                        }
                        
                        HStack {
                            Text("Retail Price:")
                                .fontWeight(.thin)
                            
                            Text("$ " + (detailDealObjectHandler.detailedDealObj?.gameInfo.retailPrice!)!)
                                .lineLimit(1)
                                .strikethrough()
                        }
                        
                        HStack {
                            Text("Sale Price:")
                                .fontWeight(.thin)
                            
                            Text("$ " + (detailDealObjectHandler.detailedDealObj?.gameInfo.salePrice!)!)
                                .lineLimit(1)
                                .foregroundStyle(.green)
                        }
                        
                        HStack {
                            Text("Steam Rating:")
                                .fontWeight(.thin)
                            if let steamRatingText = detailDealObjectHandler.detailedDealObj?.gameInfo.steamRatingText {
                                Text(steamRatingText)
                                    .lineLimit(1)
                            } else {
                                Text("N/A")
                            }
                        }
                        
                        HStack {
                            Text("Steam Rating Count:")
                                .fontWeight(.thin)
                            if let steamRatingCount = detailDealObjectHandler.detailedDealObj?.gameInfo.steamRatingCount {
                                Text(steamRatingCount)
                                    .lineLimit(1)
                            } else {
                                Text("N/A")
                            }
                        }
                        
                        HStack {
                            Text("Metacritic Score:")
                                .fontWeight(.thin)
                            if let metacriticScore = detailDealObjectHandler.detailedDealObj?.gameInfo.metacriticScore {
                                Text(metacriticScore)
                                    .lineLimit(1)
                            } else {
                                Text("N/A")
                            }
                        }
                        
                        HStack {
                            Text("Release Date:")
                                .fontWeight(.thin)
                           
                            
                            Text(convertedReleaseDate)
                                .lineLimit(1)
                                .foregroundStyle(.orange)
                        }
                        
                        HStack {
                            Text("Cheapest Price Ever:")
                                .fontWeight(.thin)
                           
                            if let cheapestPrice = detailDealObjectHandler.detailedDealObj?.cheapestPrice.price {
                                Text(cheapestPrice)
                                    .lineLimit(1)
                                    .foregroundStyle(.red)
                            } else {
                                Text("N/A")
                            }
                            
                        }
                        
                        
                        Divider()
                        
                        if let cheaperStore = detailDealObjectHandler.detailedDealObj?.cheaperStores {
                            Text("Cheaper Store")
                                .fontWeight(.thin)
                                .underline()
                                .onAppear {
                                    print(cheaperStore.count.description)
                                }
                            ScrollView {
                                ForEach(cheaperStore, id: \.dealID) { obj in
                                    let storeObj = storeObjectHandler.storeObjects.first(where: { $0.storeID == obj.storeID})
                                    VStack {
                                        Rectangle()
                                            .frame(width: 350, height: 5)
                                        HStack {
                                            AsyncImage(url: storeObj?.images?.icon) { phase in
                                                switch phase {
                                                case .empty:
                                                    ProgressView("Loading Image ...")
                                                case .success(let image):
                                                    image
                                                        .resizable()
                                                        .frame(width: 25, height: 25)
                                                        .scaledToFit()
                                                case .failure(let error):
                                                    Image("no_image50x50")
                                                        .onAppear {
                                                            print("DetailView: " + error.localizedDescription)
                                                        }
                                                @unknown default:
                                                    Image("no_image50x50")
                                                }
                                            }
                                            .padding()
                                            
                                            Text((storeObj?.storeName!)!)
                                            
                                            Divider()
                                            
                                            VStack {
                                                Text("Retail Price:")
                                                    .fontWeight(.thin)
                                                
                                                Text("$ " + (detailDealObjectHandler.detailedDealObj?.gameInfo.retailPrice!)!)
                                                    .lineLimit(1)
                                                    .strikethrough()
                                            }
                                            
                                            VStack {
                                                Text("Sale Price:")
                                                    .fontWeight(.thin)
                                                
                                                Text("$ " + (detailDealObjectHandler.detailedDealObj?.gameInfo.salePrice!)!)
                                                    .lineLimit(1)
                                                    .foregroundStyle(.green)
                                            }
                                        }
                                    }
                                }
                            }
                        }
                    }
                } else {
                    Image("blitzdeal_banner_trans")
                    Text("No data")
                }
                
            }
        }
    }
}

#Preview {
    DealDetailSheetView(dealID: "vb3EqB4KpKbSyV83DXQYAZCSBS60LaOMgLCXSt8pQxw%3D")
        .environmentObject(StoreObjectHandler.shared)
        .environmentObject(DetailDealObjectHandler())
    //    DealDetailSheetView(detailDealObj: CSDetailedDealObject(gameInfo: CSDealGameInfoObject(storeID: "1",
    //                                                                                           gameID: "41231",
    //                                                                                           name: "Bioshock Infinity",
    //                                                                                           steamAppID: "4123",
    //                                                                                           salePrice: "19.99",
    //                                                                                           retailPrice: "29.99",
    //                                                                                           steamRatingText: "Very Positive",
    //                                                                                           steamRatingPercent: "55",
    //                                                                                           steamRatingCount: "4234",
    //                                                                                           metacriticScore: "44",
    //                                                                                           metacriticLink: "",
    //                                                                                           releaseDate: 1364169600,
    //                                                                                           publisher: "N/A",
    //                                                                                           steamworks: "1",
    //                                                                                           thumb: URL(string: "https://cdn.cloudflare.steamstatic.com/steam/apps/8870/capsule_sm_120.jpg?t=1602794480")),
    //                                                            cheaperStores: [CSCheaperStores(dealID: "359$&bd%cuj/",
    //                                                                                            storeID: "4",
    //                                                                                            salePrice: "9.99",
    //                                                                                            retailPrice: "29.99")],
    //                                                            cheapestPrice: CSCheapestPrice(price: "2.99",
    //                                                                                           date: 1364169600)))
}
