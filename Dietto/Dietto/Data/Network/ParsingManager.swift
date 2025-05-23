//
//  ParsingManager.swift
//  Dietto
//
//  Created by 안세훈 on 5/23/25.
//

import Foundation

protocol ParsingManager {
    associatedtype ParsedData
    func parse(from raw: String) throws -> ParsedData
}

final class ParsingManagerImpl<Output: Decodable>: ParsingManager {
    typealias ParsedData = Output
    
    func parse(from raw: String) throws -> Output {
        let cleaned = raw
            .replacingOccurrences(of: "```json", with: "")
            .replacingOccurrences(of: "```",     with: "")
        
        guard let start = cleaned.firstIndex(of: "{"),
              let end   = cleaned.lastIndex(of: "}") else {
            throw NetworkError.invalidResponse
        }
        let jsonString = String(cleaned[start...end])
        let jsonData = Data(jsonString.utf8)
        
        let decoder = JSONDecoder()
        
        return try decoder.decode(Output.self, from: jsonData)
    }
}
