//
//  ApiEndpoint.swift
//  Blitz-Deal
//
//  Created by Viktor Schäfer on 22.02.24.
//

import Foundation

struct ApiEndpointProvider {
    static let baseUrl: String = "https://cheapshark.com/api/1.0"
    
    struct Endpoints {
        static let deals = "/deals?"
        static let games = "/games?"
        static let stores = "/stores"
    }
}
