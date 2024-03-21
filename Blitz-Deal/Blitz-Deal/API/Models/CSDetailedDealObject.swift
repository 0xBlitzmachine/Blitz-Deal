//
//  CSDetailedDealObject.swift
//  Blitz-Deal
//
//  Created by Viktor Schäfer on 21.03.24.
//

import Foundation

struct CSDetailedDealObject: Codable {
    let gameInfo: CSDealGameInfoObject
    let cheaperStores: [CSCheaperStores]
    let cheapestPrice: CSCheapestPrice
}

struct CSDealGameInfoObject: Codable {
    let storeID: String?
    let gameID: String?
    let name: String?
    let steamAppID: String?
    let salePrice: String?
    let retailPrice: String?
    let steamRatingText: String?
    let steamRatingPercent: String?
    let steamRatingCount: String?
    let metacriticScore: String?
    let metacriticLink: String?
    let releaseDate: Int?
    let publisher: String?
    let steamworks: String?
    let thumb: URL?
}

struct CSCheaperStores: Codable {
    let dealID: String?
    let storeID: String?
    let salePrice: String?
    let retailPrice: String?
}

struct CSCheapestPrice: Codable {
    let price: String?
    let date: Int?
}

/*
 {
   "gameInfo": {
     "storeID": "1",
     "gameID": "93503",
     "name": "BioShock Infinite",
     "steamAppID": "8870",
     "salePrice": "29.99",
     "retailPrice": "29.99",
     "steamRatingText": "Very Positive",
     "steamRatingPercent": "93",
     "steamRatingCount": "98477",
     "metacriticScore": "94",
     "metacriticLink": "/game/pc/bioshock-infinite",
     "releaseDate": 1364169600,
     "publisher": "N/A",
     "steamworks": "1",
     "thumb": "https://cdn.cloudflare.steamstatic.com/steam/apps/8870/capsule_sm_120.jpg?t=1602794480"
   },
   "cheaperStores": [
     {
       "dealID": "vb3EqB4KpKbSyV83DXQYAZCSBS60LaOMgLCXSt8pQxw%3D",
       "storeID": "23",
       "salePrice": "5.89",
       "retailPrice": "29.99"
     },
     {
       "dealID": "boC2N0Q7SMCKxv6UKjRw%2BLFY6%2BNLEeWM2Bf1i80clx0%3D",
       "storeID": "21",
       "salePrice": "5.99",
       "retailPrice": "29.99"
     },
     {
       "dealID": "tbqfs8HsmHWn0mMk2QRCPd7KWLidkHrIYZX3FbYCyk0%3D",
       "storeID": "30",
       "salePrice": "7.19",
       "retailPrice": "29.99"
     },
     {
       "dealID": "r%2FGHYdW6GKpZfaqR4DQrjKD7vBoWiFPP7npVpVw4350%3D",
       "storeID": "34",
       "salePrice": "7.20",
       "retailPrice": "29.99"
     },
     {
       "dealID": "OVrkWmI7sl5RN61pxpA44euybrH826w%2FjvlV%2BYKc2oA%3D",
       "storeID": "2",
       "salePrice": "7.49",
       "retailPrice": "29.99"
     },
     {
       "dealID": "5ptxhcM1fatjVrZSnNNpbSz6okheevZEhcBAZm4AUfU%3D",
       "storeID": "35",
       "salePrice": "7.50",
       "retailPrice": "29.99"
     },
     {
       "dealID": "DQ%2BYLI9do4mm0H2%2BDUd6npgoQoK8bseNvyjJe%2B%2F3dEo%3D",
       "storeID": "15",
       "salePrice": "26.28",
       "retailPrice": "29.99"
     },
     {
       "dealID": "kj2H%2FvwfkyU40jW9s2g88CAW4PuR0etKlYvkQLitgvQ%3D",
       "storeID": "29",
       "salePrice": "26.99",
       "retailPrice": "29.99"
     },
     {
       "dealID": "fq0cNHiR3Z4TpZyV7WH865C1%2BCBlmufYUc%2Bu2HqyUHE%3D",
       "storeID": "27",
       "salePrice": "26.99",
       "retailPrice": "29.99"
     }
   ],
   "cheapestPrice": {
     "price": "4.49",
     "date": 1682548425
   }
 }
 */
