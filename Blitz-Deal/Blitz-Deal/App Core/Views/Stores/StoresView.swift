//
//  StoresView.swift
//  Blitz-Deal
//
//  Created by Viktor Schäfer on 20.03.24.
//

import SwiftUI

struct StoresView: View {
    @EnvironmentObject private var storeObjectHandler: StoreObjectHandler
    private let flexibleColumn = [
            GridItem(.flexible(minimum: 150, maximum: 200)),
            GridItem(.flexible(minimum: 100, maximum: 200))

        ]
    
    var body: some View {
        NavigationStack {
            ScrollView {
                Text("Select a store to see his game deals")
                LazyVGrid(columns: flexibleColumn, content: {
                    ForEach(storeObjectHandler.storeObjects, id: \.storeID ) { storeObj in
                        StoreRow(obj: storeObj)
                            .padding()
                    }
                })
            }
            .navigationTitle("Stores")
        }
    }
}

#Preview {
    StoresView()
        .environmentObject(StoreObjectHandler.shared)
}


/*
 testObj: CSDetailedDealObject(gameInfo: CSDealGameInfoObject(storeID: "1",
                                                                         gameID: "2222",
                                                                         name: "Batman",
                                                                         steamAppID: "524352345",
                                                                         salePrice: "29.99",
                                                                         retailPrice: "59.99",
                                                                         steamRatingText: "Positiv",
                                                                         steamRatingPercent: "44",
                                                                         steamRatingCount: "55",
                                                                         metacriticScore: "55",
                                                                         metacriticLink: nil,
                                                                         releaseDate: nil,
                                                                         publisher: "N/A",
                                                                         steamworks: "1", thumb: nil),
                                          cheaperStores: [CSCheaperStores(dealID: "wdfwegf",
                                                                          storeID: "1",
                                                                          salePrice: "",
                                                                          retailPrice: "")],
                                          cheapestPrice: CSCheapestPrice(price: "",
                                                                         date: 1))
 */
