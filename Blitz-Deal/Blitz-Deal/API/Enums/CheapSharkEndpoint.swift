//
//  ApiData.swift
//  Blitz-Deal
//
//  Created by Viktor Schäfer on 22.02.24.
//

import Foundation

enum CheapSharkEndpoint: String {
    case listOfDeals
    case listOfGames
    case dealLookUp
    case gameLookUp
    case multipleGameLookUp
    case storesInfo
}

extension CheapSharkEndpoint {
    func toString() -> String {
        switch self {
        case .listOfDeals:
            return CheapSharkEndpoint.dealsEndpoint
        case .listOfGames:
            return CheapSharkEndpoint.gamesEndpoint
        case .dealLookUp:
            return CheapSharkEndpoint.dealsEndpoint
        case .gameLookUp:
            return CheapSharkEndpoint.gamesEndpoint
        case .multipleGameLookUp:
            return CheapSharkEndpoint.gamesEndpoint
        case .storesInfo:
            return CheapSharkEndpoint.storesEndpoint
        }
    }
}

extension CheapSharkEndpoint {
    private static let dealsEndpoint = "/deals?"
    private static let gamesEndpoint = "/games?"
    private static let storesEndpoint = "/stores?"
}
