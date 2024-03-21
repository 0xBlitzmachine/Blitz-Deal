//
//  DealRow.swift
//  Blitz-Deal
//
//  Created by Viktor Schäfer on 18.03.24.
//

import SwiftUI

struct DealRow: View {
    
    let dealObj: CSDealObject
    let storeObj: CSStoreObject
    
    @EnvironmentObject private var detailDealObjectHandler: DetailDealObjectHandler
    
    @Binding var isDetailViewPresented: Bool
    
    var body: some View {
        VStack {
            HStack {
                Rectangle()
                    .foregroundStyle(.red)
                    .frame(width: 5, height: 50)
                
                AsyncImage(url: dealObj.thumb!) { phase in
                    if let error = phase.error {
                        Image("no_image50x50")
                            .onAppear {
                                print(error.localizedDescription)
                            }
                    } else if let image = phase.image {
                        image
                            .resizable()
                            .frame(width: 120, height: 50)
                            .scaledToFit()
                            .border(.black)
                            .padding()
                        
                    } else {
                        ProgressView("Image Loading ...")
                    }
                }
                
                
                VStack {
                    HStack {
                        Text("Store:")
                            .fontWeight(.thin)
                        
                        AsyncImage(url: storeObj.images?.icon) { phase in
                            if let error = phase.error {
                                Image("no_image50x50")
                                    .onAppear {
                                        print(error.localizedDescription)
                                    }
                            } else if let image = phase.image {
                                image
                                    .resizable()
                                    .frame(width: 25, height: 25)
                                    .scaledToFit()
                                
                            } else {
                                ProgressView()
                            }
                        }
                    }
                    
                    Text(storeObj.storeName!)
                }
                .frame(maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/)
            }
            .padding()
            
            VStack {
                HStack {
                    Text("Title:")
                        .fontWeight(.thin)
                    
                    Text(dealObj.title!)
                        .lineLimit(1)
                }
                
                Divider()
                    .frame(width: 300)
                
                HStack {
                    Text("Normal Price:")
                        .fontWeight(.thin)
                    
                    Text("$" + dealObj.normalPrice!)
                        .strikethrough()
                }
                
                
                HStack {
                    Text("Sale Price:")
                        .fontWeight(.thin)
                    
                    Text("$" + dealObj.salePrice!)
                }
                
                Button("See details", systemImage: "info", action: {
                    Task {
                        await detailDealObjectHandler.fetchDetailsOfDeal(dealID: dealObj.dealID!)
                    }
                })
                .padding()
            }
        }
        .sheet(isPresented: $detailDealObjectHandler.showDetailedSheet, onDismiss: {
            detailDealObjectHandler.detailedDealObj = nil
        }, content: {
            DealDetailSheetView(dealID: dealObj.dealID!)
                .presentationDragIndicator(.visible)
        })
        .frame(width: 360, height: 250)
        .shadow(radius: /*@START_MENU_TOKEN@*/10/*@END_MENU_TOKEN@*/)
        .padding()
    }
}

