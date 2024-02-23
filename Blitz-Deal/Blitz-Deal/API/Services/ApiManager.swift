//
//  WebService.swift
//  Blitz-Deal
//
//  Created by Viktor Schäfer on 22.02.24.
//

import Foundation

class ApiManager {
    static func getData<T: Codable>(dataType: ApiData) async throws -> T? {
        let baseUrl = "https://cheapshark.com/api/1.0"
        
        guard let url = URL(string: (baseUrl + dataType.endpoint)) else {
            throw HttpError.badURL("API: Failed to create valid URL")
        }
        
        do {
            let (data, response) = try await URLSession.shared.data(from: url)
            guard let response = (response as? HTTPURLResponse) else {
                throw HttpError.unknown("API: Could not cast response to HTTPURLResponse?")
            }
            
            guard (200..<300).contains(response.statusCode) else {
                throw HttpError.badResponseCode("API: Bad Response Code - \(response.statusCode)")
            }
            
            do {
                return try JSONDecoder().decode(T.self, from: data)
            } catch {
                throw HttpError.failedToDecode("API: " + error.localizedDescription)
            }
            
        } catch let error as HttpError {
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
        return nil
    }
}
