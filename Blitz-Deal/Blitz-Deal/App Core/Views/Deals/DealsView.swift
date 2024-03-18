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
    
    var body: some View {
        ScrollView {
            if let objects = dealObjectHandler.dealObjects {
                ForEach(0..<objects.count, id: \.self) { index in
                    let dealObj = dealObjectHandler.dealObjects![index]
                    let storeObj = storeObjectHandler.storeObjects.first(where: { Int($0.storeID!)! == Int(dealObj.storeID!)!})
                    DealRow(dealObj: dealObj, storeObj: storeObj!)
                }
            } else {
                Image("blitzdeal_banner_trans")
                    .shadow(radius: /*@START_MENU_TOKEN@*/10/*@END_MENU_TOKEN@*/)
                
                
                Text("No Data available")
            }
        }
        .onAppear {
            Task {
                await dealObjectHandler.fetchListOfDeals()
            }
        }
    }
}

#Preview {
    DealsView()
        .environmentObject(StoreObjectHandler.shared)
}
