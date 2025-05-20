//
//  NetworkRepository.swift
//  Dietto
//
//  Created by 안세훈 on 5/19/25.
//

import Foundation

//MARK: - Alan Protocol
protocol NetworkRepository {
    func NetWorkToAlan(content : String) async throws -> AlanResponse //alan이랑 데이트하기.
}

//MARK: - Implement Alan
final class NetworkRepositoryImpl: NetworkRepository {
    
    public func NetWorkToAlan(content : String) async throws -> AlanResponse {
        var components = URLComponents(url: URL(string: "https://kdt-api-function.azurewebsites.net")!.appendingPathComponent("/api/v1/question"), resolvingAgainstBaseURL: false)
        components?.queryItems = [
            URLQueryItem(name: "client_id", value: Bundle.AlanKey),
            URLQueryItem(name: "content", value: content)
        ]
        
        let decoder = JSONDecoder()
        
        guard let url = components?.url else {
            throw URLError(.badURL)
        }
        
        let (data, response) = try await URLSession.shared.data(from: url)
        
        guard let http = response as? HTTPURLResponse, (200..<300).contains(http.statusCode) else {
            throw NetworkError.invalidResponse
        }
        
        decoder.dateDecodingStrategy = .iso8601
        let result = try decoder.decode(AlanResponse.self, from: data)
        
        return result
    }
}
