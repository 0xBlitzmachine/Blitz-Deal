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
    
    var dataIsLoaded: Bool {
        if let gameObjects {
            if gameObjects.count > 0 { return true }
            else { return false }
        }
        return false
    }
    
    func fetchGameDeals(storeID: Int, amount: Int) async {
        
        var fixedAmount: Int {
            if amount > 60 { return 60 }
            return amount
        }
        do {
            self.gameObjects = try await CheapSharkService.getData(endpoint: .listOfDeals,
                                                                   parameters: "storeID=\(storeID)&pageSize=\(amount)")
        } catch {
            print(error.localizedDescription)
        }
    }
}
