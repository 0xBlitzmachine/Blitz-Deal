//
//  HttpError.swift
//  Blitz-Deal
//
//  Created by Viktor Schäfer on 23.02.24.
//

import Foundation

enum CheapSharkServiceError: Error {
    case badURL(String)
    case badResponseCode(String)
    case failedToDecode(String)
    case unknown(String)
}
