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
    static func getData<T: Codable>(endpoint: CheapSharkEndpoint, parameters: String? = nil) async throws -> T? {
        
        var decodedData: T?
        
        var uncovertedURL: String {
            if let parameters {
                return endpoint.getFullEndpointPath() + parameters
            }
            return endpoint.getFullEndpointPath()
        }
        
        // Validated the URL
        guard let url = URL(string: uncovertedURL) else {
            throw CheapSharkServiceError.badURL
        }
        
        // Do the call once the URL is valid
        do {
            // Try the call
            let (data, response) = try await URLSession.shared.data(from: url)
            // Cast URLResponse to HTTPURLResponse to get the status Code
            guard let response = (response as? HTTPURLResponse) else {
                throw CheapSharkServiceError.unknown
            }
            // Check for a valid response code
            guard (200..<300).contains(response.statusCode) else {
                throw CheapSharkServiceError.badResponseCode(response.statusCode)
            }
            // Encode the JSON response to our object
            do {
                decodedData = try JSONDecoder().decode(T.self, from: data)
            } catch {
                throw CheapSharkServiceError.failedToDecode(error.localizedDescription)
            }
            
        } catch let error as CheapSharkServiceError {
            switch error {
            case .badURL:
                print("The URL is in bad format! - API Call failed")
            case .badResponseCode(let responseCode):
                print("Got an bad API Response: \(responseCode)")
            case .failedToDecode(let errorMessage):
                print(errorMessage)
            case .unknown:
                print("An unknown event occured!")
            }
        }
        print(url.absoluteString)
        return decodedData
    }
}
