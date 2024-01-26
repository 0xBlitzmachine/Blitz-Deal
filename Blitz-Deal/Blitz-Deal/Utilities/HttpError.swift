//
//  HttpError.swift
//  Blitz-Deal
//
//  Created by Viktor Schäfer on 15.01.24.
//

import Foundation

enum HttpError: Error {
    case invalidUrl
    case invalidResponse
    case failedToDecode
    case badStatusCode
}
