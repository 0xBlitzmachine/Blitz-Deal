//
//  DealsView.swift
//  Blitz-Deal
//
//  Created by Viktor Schäfer on 17.03.24.
//

import SwiftUI

struct DealsView: View {
    
    @EnvironmentObject private var storeObjectHandler: StoreObjectHandler
    @StateObject private var dealObjectHandler = DealObjectHandler()
    
    @State private var pageNumber: Int = 0
    private let pageLimit: Int = 50
    
    init() {
        self.fetchData()
    }
    
    var body: some View {
        if dealObjectHandler.isDataLoading == false {
            HStack {
                Button("Previous Page") {
                    
                }
                .padding()
                
                Text("Current Page: \(pageNumber)")
                
                Button("Next Page") {
                    
                }
                .padding()
            }
            ScrollView {
                if let dealObjects = dealObjectHandler.dealObjects {
                    ForEach(dealObjects, id: \.dealID) { obj in
                        let storeObj = storeObjectHandler.storeObjects.first(where: { Int($0.storeID!)! == Int(obj.storeID!)!})
                        DealRow(dealObj: obj, storeObj: storeObj!)
                    }
                } else {
                    Image("blitzdeal_banner_trans")
                        .shadow(radius: /*@START_MENU_TOKEN@*/10/*@END_MENU_TOKEN@*/)
                    
                    Text("ERROR: No data provided to work with!")
                }
            }
        } else {
            VStack {
                Image("blitzdeal_banner_trans")
                    .shadow(radius: 5)
                
                ProgressView("Fetching more Deals ...")
            }
        }
    }
    
    private func fetchData() {
        Task {
            await dealObjectHandler.fetchListOfDeals(parameters: "pageSize=60&pageNumber=\(pageNumber)")
        }
    }
}

#Preview {
    DealsView()
        .environmentObject(StoreObjectHandler.shared)
}
