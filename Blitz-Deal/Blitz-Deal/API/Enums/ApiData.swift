//
//  ApiData.swift
//  Blitz-Deal
//
//  Created by Viktor Schäfer on 22.02.24.
//

import Foundation

enum ApiData: String {
    case listOfDeals
    case listOfGames
    case dealLookUp
    case gameLookUp
    case multipleGameLookUp
    case storesInfo
    
    var endpoint: String {
        switch self {
        case .listOfDeals:
            return ApiData.dealsEndpoint
        case .listOfGames:
            return ApiData.gamesEndpoint
        case .dealLookUp:
            return ApiData.dealsEndpoint
        case .gameLookUp:
            return ApiData.gamesEndpoint
        case .multipleGameLookUp:
            return ApiData.gamesEndpoint
        case .storesInfo:
            return ApiData.storesEndpoint
        }
    }
}

extension ApiData {
    static let dealsEndpoint = "/deals?"
    static let gamesEndpoint = "/games?"
    static let storesEndpoint = "/stores?"
}
