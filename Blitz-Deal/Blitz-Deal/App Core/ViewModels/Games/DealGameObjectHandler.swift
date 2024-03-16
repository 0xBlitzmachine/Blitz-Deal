//
//  GameObjectHandler.swift
//  Blitz-Deal
//
//  Created by Viktor Schäfer on 15.03.24.
//

import Foundation

@MainActor
class DealGameObjectHandler: ObservableObject {
    
    @Published var gameObjects: [CSDealGameObject]?
    @Published var dataLoaded: Bool = false
    
    func fetchGameDeals(storeID: Int, amount: Int, page: Int = 0) async {
        
        var fixedAmount: Int {
            if amount > 60 { return 60 }
            return amount
        }
        do {
            let tempGameObjects: [CSDealGameObject]? = try await CheapSharkService.getData(endpoint: .listOfDeals,
                                                                                           parameters: "storeID=\(storeID)&pageSize=\(amount)&pageNumber=\(page)")
            
            guard let tempGameObjects else { return }
            self.gameObjects = tempGameObjects
            self.dataLoaded = true
        } catch {
            print(error.localizedDescription)
        }
    }
}
