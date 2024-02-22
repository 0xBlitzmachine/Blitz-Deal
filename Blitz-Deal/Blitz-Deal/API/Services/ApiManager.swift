//
//  WebService.swift
//  Blitz-Deal
//
//  Created by Viktor Schäfer on 22.02.24.
//

import Foundation

class ApiManager {
    func getData<T: Codable>(dataType: ApiData) -> T {
        var validUrl: URL
        
        switch dataType {
        case .listOfDeals:
            
        case .listOfGames:
            <#code#>
        case .dealLookUp:
            <#code#>
        case .gameLookUp:
            <#code#>
        case .multipleGameLookUp:
            <#code#>
        case .storesInfo:
            validUrl = 
        }
        
    }
}
