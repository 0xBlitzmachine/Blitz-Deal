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
    
    
    let maxPageNumber: Int = 50
    let minPageNumber: Int = 0
    
    private var _currentPage: Int = 0
    var currentPage: Int {
        get { return _currentPage }
        set {
            if newValue > maxPageNumber {
                _currentPage = maxPageNumber
            } else if newValue < minPageNumber {
                _currentPage = minPageNumber
            } else {
                _currentPage = newValue
            }
        }
    }
    
    
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
        }
    }
    
    func increasePageNumber() {
        self.currentPage += 1
    }
    
    func decreasePageNumber() {
        self.currentPage -= 1
    }
}
