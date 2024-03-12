//
//  HttpError.swift
//  Blitz-Deal
//
//  Created by Viktor Schäfer on 23.02.24.
//

import Foundation

enum CheapSharkServiceError: Error {
    case badURL
    case badResponseCode(Int)
    case failedToDecode(String)
    case unknown
}
