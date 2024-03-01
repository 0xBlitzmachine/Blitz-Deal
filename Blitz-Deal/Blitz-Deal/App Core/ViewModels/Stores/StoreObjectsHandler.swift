//
//  StoreObjectsHandler.swift
//  Blitz-Deal
//
//  Created by Viktor Schäfer on 29.02.24.
//

import Foundation

@MainActor
class StoreObjectsHandler: ObservableObject {
    private let storeObjectManager: StoreObjectsManager = .singletonInstance
    
    @Published var storeObjects: [CheapSharkStoreObject] = .init()
    var rawStoreObjects: [StoreObject] = .init()
    
    init() {
        self.storeObjectManager.fetchIntoContext { result in
            switch result {
            case .success(let success):
                self.rawStoreObjects = success
                self.storeObjects = success.castToCheapSharkObjectArray()
            case .failure(let failure):
                print(failure.localizedDescription)
            }
        }
        
        self.validateDatabaseContent()
    }
    
    func createObject(object: CheapSharkStoreObject) {
        object.castToStoreObject(context: self.storeObjectManager.context)
        self.saveAndFetchContext()
    }
    
    func deleteObject(object: StoreObject) {
        self.storeObjectManager.context.delete(object)
        self.saveAndFetchContext()
    }
}

extension StoreObjectsHandler {
    private func saveAndFetchContext() {
        self.storeObjectManager.saveContext()
        self.storeObjectManager.fetchIntoContext { result in
            switch result {
            case .success(let success):
                self.rawStoreObjects = success
                self.storeObjects = success.castToCheapSharkObjectArray()
                
            case .failure(let failure):
                print(failure.localizedDescription)
            }
        }
    }
}

extension StoreObjectsHandler {
    private func validateDatabaseContent() {
        Task {
            let data: [CheapSharkStoreObject]? = try await CheapSharkService.getData(.storesInfo)
            
            if self.rawStoreObjects.isEmpty {
                print("RawStoreObjects is Empty")
                if let data = data {
                    data.forEach({ object in
                        object.castToStoreObject(context: self.storeObjectManager.context)
                    })
                    self.saveAndFetchContext()
                }
            } else {
                print("RawStoreObjects not Empty!")
                self.rawStoreObjects.forEach { object in
                    self.deleteObject(object: object)
                }
                
                if let data = data {
                    data.forEach({ object in
                        object.castToStoreObject(context: self.storeObjectManager.context)
                    })
                }
                self.saveAndFetchContext()
            }
        }
    }
}

extension StoreObjectsHandler {
    static let singletonInstance: StoreObjectsHandler = .init()
}
