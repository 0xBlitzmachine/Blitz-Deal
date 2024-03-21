//
//  DealsView.swift
//  Blitz-Deal
//
//  Created by Viktor Schäfer on 17.03.24.
//

import SwiftUI
import SSToastMessage

struct DealsView: View {
    
    @EnvironmentObject private var storeObjectHandler: StoreObjectHandler
    
    @StateObject private var dealObjectHandler: DealObjectHandler = .init()
    @StateObject private var detailDealObjectHandler: DetailDealObjectHandler = .init()
    
    var storeID: String?
    
    @State var isDetailSheetPresented = false
    
    init(storeID: String? = nil) {
        self.storeID = storeID
    }
    
    var body: some View {
        if dealObjectHandler.isDataLoading == false {
            VStack {
                ScrollView {
                    if let dealObjects = dealObjectHandler.dealObjects {
                        HStack {
                            Button("Previous Page") {
                                dealObjectHandler.decreasePageNumber()
                                self.fetchData()
                            }
                            .disabled(dealObjectHandler.currentPage == dealObjectHandler.minPageNumber)
                            
                            
                            Text("Current Page: \(dealObjectHandler.currentPage)")
                                .padding()
                            
                            Button("Next Page") {
                                dealObjectHandler.increasePageNumber()
                                self.fetchData()
                            }
                            .disabled(dealObjectHandler.currentPage == dealObjectHandler.maxPageNumber)
                        }
                        
                        ForEach(dealObjects, id: \.dealID) { obj in
                            let storeObj = storeObjectHandler.storeObjects.first(where: {
                                Int($0.storeID!)! == Int(obj.storeID!)!
                            })
                            
                            DealRow(dealObj: obj,
                                    storeObj: storeObj!,
                                    isDetailViewPresented: $isDetailSheetPresented)
                            .environmentObject(detailDealObjectHandler)
                            
                            Divider()
                        }
                    } else {
                        if storeID == nil {
                            Text("Welcome to ")
                                .font(.title3)
                                .fontWeight(.ultraLight)
                                .padding()
                        }
                        
                        Image("blitzdeal_banner_trans")
                            .shadow(radius: /*@START_MENU_TOKEN@*/10/*@END_MENU_TOKEN@*/)
                            .frame(height: 200)
                        
                        Divider()
                            .padding(50)
                        
                        if storeID == nil {
                            Image(systemName: "info.square.fill")
                                .padding(5)
                                .foregroundStyle(Color.accentColor)
                                .scaleEffect(CGSize(width: 2, height: 2))
                        }
                        
                        if storeID == nil {
                            Text("By clicking on 'Request Data' you will fetch newest random deals. You can navigate up to 50 pages of deals. One Page has a total of 60 deals!")
                                .padding(.horizontal, 50)
                                .padding(.top, 20)
                                .padding(.bottom, 100)
                        }
                        
                        
                        Button("Request Data") {
                            self.fetchData()
                        }
                        .buttonStyle(.borderedProminent)
                        .fontWeight(.semibold)
                    }
                }
            }
        } else {
            VStack {
                Image("blitzdeal_banner_trans")
                    .shadow(radius: 5)
                
                Divider()
                    .padding()
                
                ProgressView("Requesting Data ...")
            }
        }
    }
    
    private func fetchData() {
        if storeID != nil {
            Task {
                await dealObjectHandler.fetchListOfDeals(parameters: "storeID=\(storeID!)&pageNumber=\(dealObjectHandler.currentPage)")
            }
        } else {
            Task {
                await dealObjectHandler.fetchListOfDeals(parameters: "pageNumber=\(dealObjectHandler.currentPage)")
            }
        }
        
    }
}

#Preview {
    DealsView()
        .environmentObject(StoreObjectHandler.shared)
}
