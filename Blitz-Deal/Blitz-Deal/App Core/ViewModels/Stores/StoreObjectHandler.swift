//
//  StoreObjectsHandler.swift
//  Blitz-Deal
//
//  Created by Viktor Schäfer on 29.02.24.
//

import Foundation

@MainActor
class StoreObjectHandler: ObservableObject {
    
    init() {
        self.saveAndFetchContext()
    }
    
    private let storeObjectManager: StoreObjectsManager = .shared
    
    @Published var dataStatusMessage = String()
    @Published var dataLoaded: Bool = false
    
    @Published var storeObjects: [CSStoreObject] = .init()
    var rawStoreObjects: [StoreObject] = .init()
    
    func createObject(object: CSStoreObject) {
        object.castToStoreObject(context: self.storeObjectManager.context)
        self.saveAndFetchContext()
    }
    
    func deleteObject(object: StoreObject) {
        self.storeObjectManager.context.delete(object)
        self.saveAndFetchContext()
    }
}


extension StoreObjectHandler {
    
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
    
     func validateDataLoaded() {
        guard !self.dataLoaded else { return }
        guard self.storeObjects.count > 0 else {
            self.dataStatusMessage = "Failed to load data!"
            return
        }
        self.dataLoaded.toggle()
    }
    
    func validateDatabaseContent() async throws {
        self.dataStatusMessage = "Trying to get data from CheapShark ..."
        try await Task.sleep(for: .seconds(0.3))
        let data: [CSStoreObject]? = try await CheapSharkService.getData(endpoint: .storesInfo)
        
        self.dataStatusMessage = "Proccessing data ..."
        try await Task.sleep(for: .seconds(0.3))
        
        if self.rawStoreObjects.isEmpty {
            self.dataStatusMessage = "Local database is empty"
            try await Task.sleep(for: .seconds(0.3))
            
            self.dataStatusMessage = "Filling local database ..."
            if let data {
                data.forEach({ object in
                    object.castToStoreObject(context: self.storeObjectManager.context)
                })
                self.dataStatusMessage = "Local database filled!"
                self.saveAndFetchContext()
            }
        } else {
            self.dataStatusMessage = "Correcting local database ..."
            try await Task.sleep(for: .seconds(0.3))
            
            self.rawStoreObjects.forEach { object in
                self.deleteObject(object: object)
            }
            
            if let data {
                data.forEach({ object in
                    object.castToStoreObject(context: self.storeObjectManager.context)
                })
            }

            self.dataStatusMessage = "Database corrected!"
            try await Task.sleep(for: .seconds(0.5))
            self.saveAndFetchContext()
        }
    }
}

extension StoreObjectHandler {
    static let shared: StoreObjectHandler = .init()
}
