//
//  ApiData.swift
//  Blitz-Deal
//
//  Created by Viktor Schäfer on 22.02.24.
//

import Foundation

enum CheapSharkEndpoint {
    case listOfDeals
    case listOfGames
    case dealLookUp
    case gameLookUp
    case multipleGameLookUp
    case storesInfo
}

extension CheapSharkEndpoint {
     
    static let url = "https://cheapshark.com" + base
    private static let base = "/api/1.0"
    
    private static let dealsEndpoint = "/deals?"
    private static let gamesEndpoint = "/games?"
    private static let storesEndpoint = "/stores?"
    
    func getFullEndpointPath() -> String {
        switch self {
        case .listOfDeals:
            return CheapSharkEndpoint.url + CheapSharkEndpoint.dealsEndpoint
        case .listOfGames:
            return CheapSharkEndpoint.url + CheapSharkEndpoint.gamesEndpoint
        case .dealLookUp:
            return CheapSharkEndpoint.url + CheapSharkEndpoint.dealsEndpoint
        case .gameLookUp:
            return CheapSharkEndpoint.url + CheapSharkEndpoint.gamesEndpoint
        case .multipleGameLookUp:
            return CheapSharkEndpoint.url + CheapSharkEndpoint.gamesEndpoint
        case .storesInfo:
            return CheapSharkEndpoint.url + CheapSharkEndpoint.storesEndpoint
        }
    }
}
