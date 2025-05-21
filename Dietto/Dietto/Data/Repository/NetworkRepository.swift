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

//MARK: - Alan Protocol Implment
final class NetworkRepositoryImpl: NetworkRepository {
    
    public func NetWorkToAlan(content: String) async throws -> AlanResponse {
        var components = URLComponents(url: URL(string: "https://kdt-api-function.azurewebsites.net")!.appendingPathComponent("/api/v1/question"), resolvingAgainstBaseURL: false)
        
        components?.queryItems = [
            URLQueryItem(name: "client_id", value: Bundle.AlanKey),
            URLQueryItem(name: "content", value: content)
        ]
        //에러 처리
        do {
            guard let url = components?.url else {
                throw URLError(.badURL)
            }
            
            let (data, response) = try await URLSession.shared.data(from: url)
            
            guard let httpResponse = response as? HTTPURLResponse else {
                throw NetworkError.invalidResponse
            }
            
            switch httpResponse.statusCode {
            case 200..<300:
                break  // 통과
            case 400:
                throw NetworkError.badRequest
            case 401:
                throw NetworkError.unauthorized
            case 403:
                throw NetworkError.forbidden
            case 404:
                throw NetworkError.notFound
            case 500..<600:
                throw NetworkError.serverError(httpResponse.statusCode)
            default:
                throw NetworkError.unacceptableStatusCode
            }
            
            let decoder = JSONDecoder()
            decoder.dateDecodingStrategy = .iso8601
            
            do {
                let result = try decoder.decode(AlanResponse.self, from: data)
                return result
            } catch {
                throw NetworkError.decodingFailed(error)
            }
            
        } catch let error as URLError where error.code == .cancelled {
            throw NetworkError.requestCancelled
        } catch {
            throw NetworkError.unknown(error)
        }
    }
}
