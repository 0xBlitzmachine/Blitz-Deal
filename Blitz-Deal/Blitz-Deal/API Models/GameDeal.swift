//
//  GameDeal.swift
//  Blitz-Deal
//
//  Created by Viktor Schäfer on 15.01.24.
//

import Foundation

struct GameDeal: Codable {
    let internalName: String?
    let title: String?
    let dealID: String?
    let storeID: String?
    let gameID: String?
    
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


/**
 {
     "internalName": "DEUSEXHUMANREVOLUTIONDIRECTORSCUT",
     "title": "Deus Ex: Human Revolution - Director's Cut",
     "metacriticLink": "/game/pc/deus-ex-human-revolution---directors-cut",
     "dealID": "HhzMJAgQYGZ%2B%2BFPpBG%2BRFcuUQZJO3KXvlnyYYGwGUfU%3D",
     "storeID": "1",
     "gameID": "102249",
     "salePrice": "2.99",
     "normalPrice": "19.99",
     "isOnSale": "1",
     "savings": "85.042521",
     "metacriticScore": "91",
     "steamRatingText": "Very Positive",
     "steamRatingPercent": "92",
     "steamRatingCount": "17993",
     "steamAppID": "238010",
     "releaseDate": 1382400000,
     "lastChange": 1621536418,
     "dealRating": "9.6",
     "thumb": "https://cdn.cloudflare.steamstatic.com/steam/apps/238010/capsule_sm_120.jpg?t=1619788192"
   }
 */
