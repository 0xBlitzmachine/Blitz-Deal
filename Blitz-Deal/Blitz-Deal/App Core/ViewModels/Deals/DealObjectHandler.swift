//
//  DealObjectHandler.swift
//  Blitz-Deal
//
//  Created by Viktor Schäfer on 18.03.24.
//

import Foundation

@MainActor
class DealObjectHandler: ObservableObject {
    
    @Published var dealObjects: [CSDealObject]?
    @Published var isDataLoading: Bool = false
    
    private let pageLimit: Int = 50
    
    
    func fetchListOfDeals(parameters: String = String()) async {
        
        self.isDataLoading = true
        
        do {
            let fetchedObjs: [CSDealObject]? = try await CheapSharkService.getData(endpoint: .listOfDeals,
                                                                                       parameters: parameters)
            if var dealObjects {
                if let fetchedObjs {
                    var objs: [CSDealObject] = .init()
                    fetchedObjs.forEach( { obj in
                        if !(dealObjects.contains(where: { $0.dealID == obj.dealID })) {
                            objs.append(obj)
                        }
                    })
                    
                    self.dealObjects = objs
                } else {
                    print("List of Dealobjects is not nil but the requested data is!")
                }
            } else {
                if let fetchedObjs {
                    self.dealObjects = fetchedObjs
                }
            }
            
            self.isDataLoading = false
            
        } catch {
            self.isDataLoading = false
            print(error.localizedDescription)
        }
        
    }
}
