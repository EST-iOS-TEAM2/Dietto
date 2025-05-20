//
//  AlanUseCase.swift
//  Dietto
//
//  Created by 안세훈 on 5/19/25.
//

import Foundation

//MARK: - usecase

protocol AlanUseCase {
    func fetchAlanRecommendDietary(ingredients: [IngredientEntity]) async throws -> [RecommendEntity]
}

//MARK: - usecaseimpl
final class AlanUseCaseImpl : AlanUseCase {
    
    private let repository: NetworkRepository
    private let encoder: JSONEncoder
    
    init(repository: NetworkRepository, encoder: JSONEncoder = JSONEncoder()) {
        self.repository = repository
        self.encoder = encoder
    }
    
    func fetchAlanRecommendDietary(ingredients: [IngredientEntity]) async throws -> [RecommendEntity] {
        
        let names = ingredients.map { $0.name }
        
        let prompt = """
            당신은 영양사입니다. 다음 재료로 만들 수 있는 건강한 식단을 추천해 주세요. 응답은 JSON 배열 형태로 제공해 주세요.
            이 세상에 존재하는 메뉴이어야 하고 메뉴가 너무 변형되거나 핀트가 벗어난 음식은 알려주지 말아야해요.
            그리고 영양학적으로 균형잡힌 식사메뉴여야해요. 최대 10개의 음식을 보여주세요. 적어도 괜찮습니다.
            
            
            {
              "recommendations": [
                { "title": "제목1", "description": "설명1" },
                { "title": "제목2", "description": "설명2" }
              ]
            }
            
            재료: \(names.joined(separator: ", "))
            """
        
        let alanResponse = try await repository.NetWorkToAlan(content: prompt)
        let raw = alanResponse.content
        
        let cleaned = raw
            .replacingOccurrences(of: "```json", with: "")
            .replacingOccurrences(of: "```", with: "")
        
        
        guard let start = cleaned.firstIndex(of: "{"),
              let end = cleaned.lastIndex(of: "}") else {
            throw URLError(.cannotParseResponse)
        }
        
        let jsonString = String(cleaned[start...end])
        let jsonData = Data(jsonString.utf8)
        
        
        struct RecommendationWrapper: Decodable {
            let recommendations: [RecommendEntity]
        }
        
        let wrapper = try JSONDecoder().decode(RecommendationWrapper.self, from: jsonData)
        return wrapper.recommendations
    }
    
}

