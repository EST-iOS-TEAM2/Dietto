//
//  NetworkManager.swift
//  Dietto
//
//  Created by 안세훈 on 5/23/25.
//

import Foundation

protocol NetworkManager {
    func request(request prompt: String) async throws -> String
}

final class NetworkManagerImpl: NetworkManager {
    func request(request prompt: String) async throws -> String {
        var components = URLComponents(string: "https://kdt-api-function.azurewebsites.net/api/v1/question")
        components?.queryItems = [
            URLQueryItem(name: "client_id", value: Bundle.AlanKey),
            URLQueryItem(name: "content",   value: prompt)
        ]
        guard let url = components?.url else {
            throw NetworkError.badRequest
        }

        let (data, response) = try await URLSession.shared.data(from: url)
        guard let http = response as? HTTPURLResponse,
              200..<300 ~= http.statusCode else {
            throw NetworkError.invalidResponse
        }
        guard let raw = String(data: data, encoding: .utf8) else {
            throw NetworkError.invalidResponse
        }

        return raw
    }
}
