//
//  DetailDealObjectHandler.swift
//  Blitz-Deal
//
//  Created by Viktor Schäfer on 21.03.24.
//

import Foundation

@MainActor
class DetailDealObjectHandler: ObservableObject {
    
    @Published var detailedDealObj: CSDetailedDealObject?
    @Published var isDataLoading = false
    @Published var showDetailedSheet = false
    
    func fetchDetailsOfDeal(dealID: String) async {
        self.isDataLoading = true
        
        do {
            self.detailedDealObj = try await CheapSharkService.getData(endpoint: .dealLookUp, parameters: "id=\(dealID)")
            self.isDataLoading = false
            self.toggleDetailSheet()
        } catch {
            self.isDataLoading = false
            print(error.localizedDescription)
        }
    }
    
    func toggleDetailSheet() {
        self.showDetailedSheet.toggle()
    }
}
