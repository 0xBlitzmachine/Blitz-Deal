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
            print("API CALL ERROR : 0")
            return nil
        }
        
        do {
            let (data, response) = try await URLSession.shared.data(from: url)
            guard let response = (response as? HTTPURLResponse), (200..<300).contains(response.statusCode) else {
                print("API CALL ERROR : BAD STATUS")
                return nil
            }
            do {
                return try JSONDecoder().decode(T.self, from: data)
            } catch {
                print(error.localizedDescription)
                return nil
            }
        } catch {
            print(error.localizedDescription)
            return nil
        }
    }
}
