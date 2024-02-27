//
//  WebService.swift
//  Blitz-Deal
//
//  Created by Viktor Schäfer on 22.02.24.
//

import Foundation

class CheapSharkService {
    // Generic function with multi selection for endpoints
    // TODO: Add ability to add parameters to endpoints!
    static func getData<T: Codable>(_ endpoint: CheapSharkEndpoint) async throws -> T? {
        let baseUrl = "https://cheapshark.com/api/1.0"
        var decodedData: T? = nil
        
        // Validated the URL
        guard let url = URL(string: (baseUrl + endpoint.toString())) else {
            throw CheapSharkServiceError.badURL("API: Failed to create valid URL")
        }
        
        // Do the call once the URL is valid
        do {
            // Try the call
            let (data, response) = try await URLSession.shared.data(from: url)
            // Cast URLResponse to HTTPURLResponse to get the status Code
            guard let response = (response as? HTTPURLResponse) else {
                throw CheapSharkServiceError.unknown("API: Could not cast response to HTTPURLResponse?")
            }
            // Check for a valid response code
            guard (200..<300).contains(response.statusCode) else {
                throw CheapSharkServiceError.badResponseCode("API: Bad Response Code - \(response.statusCode)")
            }
            // Encode the JSON response to our object
            do {
                decodedData = try JSONDecoder().decode(T.self, from: data)
            } catch {
                throw CheapSharkServiceError.failedToDecode("API - DECODING: " + error.localizedDescription)
            }
            
        } catch let error as CheapSharkServiceError {
            switch error {
            case .badURL(let errorMessage):
                print(errorMessage)
            case .badResponseCode(let errorMessage):
                print(errorMessage)
            case .failedToDecode(let errorMessage):
                print(errorMessage)
            case .unknown(let errorMessage):
                print(errorMessage)
            }
        }
        return decodedData
    }
}
