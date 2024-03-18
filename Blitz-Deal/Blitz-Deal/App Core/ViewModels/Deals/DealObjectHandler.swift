//
//  DealObjectHandler.swift
//  Blitz-Deal
//
//  Created by Viktor Schäfer on 18.03.24.
//

import Foundation

class DealObjectHandler: ObservableObject {
    
    @Published var dealObjects: [CSDealGameObject]?
    @Published var isDataLoading: Bool = false

    private let pageLimit: Int = 50
    
    
    func fetchListOfDeals(storeID: Int? = nil, page: Int? = nil) async {
        var parameters = String()
        
        self.isDataLoading = true
        
        if let storeID, var page {
            if page > self.pageLimit {
                page = self.pageLimit
            }
            parameters = "storeID=\(storeID)&pageNumber=\(page)"
        } else if let storeID {
            parameters = "storeID=\(storeID)"
        } else if var page {
            if page > self.pageLimit {
                page = self.pageLimit
            }
            parameters = "pageNumber=\(page)"
        }
        
        do {
            let fetchedObjs: [CSDealGameObject]? = try await CheapSharkService.getData(endpoint: .listOfDeals,
                                                                   parameters: parameters)
            
            if self.dealObjects == nil {
                self.dealObjects = fetchedObjs
            } else {
                fetchedObjs?.forEach( { obj in
                    if !(self.dealObjects?.contains(where: { $0.dealID == obj.dealID }))! {
                        self.dealObjects?.append(obj)
                    }
                })
            }
            
            self.isDataLoading = false
            
        } catch {
            self.isDataLoading = false
            print(error.localizedDescription)
        }
        
    }
}
