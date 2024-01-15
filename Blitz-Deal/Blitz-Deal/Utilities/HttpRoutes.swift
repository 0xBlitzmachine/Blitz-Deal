//
//  APIEndpoints.swift
//  Blitz-Deal
//
//  Created by Viktor Schäfer on 15.01.24.
//

import Foundation

struct APIEndpoints {
    static private let baseApiUrl = "https://www.cheapshark.com/api/1.0/"
    
    static let baseUrl = "https://www.cheapshark.com"
    static let dealsEndpoint = "\(baseApiUrl)deals?"
    static let gamesEndpoint = "\(baseApiUrl)games?"
}
