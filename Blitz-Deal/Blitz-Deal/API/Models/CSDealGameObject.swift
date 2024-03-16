//
//  CheapSharkGameObject.swift
//  Blitz-Deal
//
//  Created by Viktor Schäfer on 13.03.24.
//

import Foundation

struct CSDealGameObject: Codable, Equatable {
    let gameID: String?
    let title: String?
    let dealID: String?
    let storeID: String?
    let salePrice: String?
    let normalPrice: String?
    let isOnSale: String?
    let savings: String?
    let metacriticScore: String?
    let steamRatingText: String?
    let steamRatingPercent: String?
    let steamRatingCount: String?
    let steamAppID: String?
    let releaseDate: Int?
    let lastChange: Int?
    let dealRating: String?
    let thumb: URL?
}
