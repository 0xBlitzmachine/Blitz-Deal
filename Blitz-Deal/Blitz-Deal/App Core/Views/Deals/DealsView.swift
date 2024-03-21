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
    
    @State var isDetailSheetPresented = false
    
    @State private var pageNumber: Int = 0
    private let pageLimit: Int = 50
    
    init() {
        self.fetchData()
    }
    
    var body: some View {
        if dealObjectHandler.isDataLoading == false {
            ScrollView {
                if let dealObjects = dealObjectHandler.dealObjects {
                    HStack {
                        Button("Previous Page") {
                            guard pageNumber > 0 else { return }
                            pageNumber -= 1
                            self.fetchData()
                        }
                       
                        
                        Text("Current Page: \(pageNumber)")
                            .padding()
                        
                        Button("Next Page") {
                            guard pageNumber < pageLimit else { return }
                            pageNumber += 1
                            self.fetchData()
                        }
                    }
                    
                    ForEach(dealObjects, id: \.dealID) { obj in
                        let storeObj = storeObjectHandler.storeObjects.first(where: {
                            Int($0.storeID!)! == Int(obj.storeID!)!
                        })
                        
                        DealRow(dealObj: obj,
                                storeObj: storeObj!,
                                isDetailViewPresented: $isDetailSheetPresented)
                        
                        Divider()
                    }
                } else {
                    Image("blitzdeal_banner_trans")
                        .shadow(radius: /*@START_MENU_TOKEN@*/10/*@END_MENU_TOKEN@*/)
                    
                    Button("Request Data") {
                        self.fetchData()
                    }
                }
            }
        } else {
            VStack {
                Image("blitzdeal_banner_trans")
                    .shadow(radius: 5)
                
                ProgressView("Requesting Data ...")
            }
        }
    }
    
    private func fetchData() {
        Task {
            await dealObjectHandler.fetchListOfDeals(parameters: "pageNumber=\(pageNumber)")
        }
    }
}

#Preview {
    DealsView()
        .environmentObject(StoreObjectHandler.shared)
}
