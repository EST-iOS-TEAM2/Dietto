//
//  ParsingManager.swift
//  Dietto
//
//  Created by 안세훈 on 5/23/25.
//

import Foundation

protocol ParsingManager {
    func parse<Output: Decodable>(from raw: String, as type: Output.Type) throws -> Output
}

final class ParsingManagerImpl: ParsingManager {
    func parse<Output: Decodable>(from raw: String, as type: Output.Type) throws -> Output {
        let cleaned = raw
            .replacingOccurrences(of: "```json", with: "")
            .replacingOccurrences(of: "```",     with: "")
        
        let data = Data(cleaned.utf8)
        let decoder = JSONDecoder()
        
        let responseData = try decoder.decode(AlanResponse.self, from: data)
        
        guard let start = responseData.content.firstIndex(of: "{"),
              let end   = responseData.content.lastIndex(of: "}") else {
            throw NetworkError.invalidResponse
        }
        let jsonBody = responseData.content[start...end]
        let bodyData = Data(jsonBody.utf8)
        
        return try decoder.decode(Output.self, from: bodyData)
    }
}
