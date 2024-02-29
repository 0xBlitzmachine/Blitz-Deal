//
//  StoreObjectsHandler.swift
//  Blitz-Deal
//
//  Created by Viktor Schäfer on 29.02.24.
//

import Foundation

class StoreObjectsHandler: ObservableObject {
    private let storeObjectManager: StoreObjectsManager
    @Published var storeObjects: [StoreObject]
    
    init() {
        self.storeObjectManager = .singletonInstance
        self.storeObjectManager.fetchIntoContext { result in
            switch result {
            case .success(let success):
                self.storeObjects = success
            case .failure(let failure):
                print(failure.localizedDescription)
            }
        }
    }
    
    func createObject(object: CheapSharkStoreObject) {
        object.castToStoreObject(context: <#T##NSManagedObjectContext#>)
    }
    
    func deleteObject() {
        
    }
}
