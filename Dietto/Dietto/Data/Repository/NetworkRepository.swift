//
//  NetworkRepository.swift
//  Dietto
//
//  Created by 안세훈 on 5/19/25.
//

import Foundation

//MARK: - Alan Interface
protocol NetworkRepository {
    func fetch<T: Decodable>(promptType: PromptType, rawValues: [Any], outputType: T.Type) async throws -> T}

//MARK: - Alan Implement
final class NetworkRepositoryImpl: NetworkRepository {
    
    private let promptManager: PromptManager
    private let networkManager: NetworkManager
    private let parsingManager: ParsingManager
    
    init(promptManager: PromptManager = PromptManagerImpl(),
         networkManager: NetworkManager = NetworkManagerImpl(),
         parsingManager : ParsingManager  = ParsingManagerImpl()
    ) {
        self.promptManager = promptManager
        self.networkManager = networkManager
        self.parsingManager = parsingManager
    }
    
    func fetch<T>(promptType: PromptType, rawValues: [Any], outputType: T.Type) async throws -> T where T: Decodable {
        let values: [String] = rawValues.compactMap {
            if let ing = $0 as? IngredientEntity { return ing.ingredient }
            if let art = $0 as? InterestEntity { return art.title }
            return nil
        }
        let prompt = promptManager.makePrompt(for: promptType, with: values)
        
        let rawResponse = try await networkManager.request(request: prompt)
        
        return try parsingManager.parse(from: rawResponse, as: T.self)
    }
}
