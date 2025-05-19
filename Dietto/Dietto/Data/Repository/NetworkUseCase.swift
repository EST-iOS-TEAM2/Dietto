//
//  NetworkUseCase.swift
//  Dietto
//
//  Created by 안세훈 on 5/19/25.
//

import Foundation

//MARK: - usecase

protocol NetworkUseCase {
    func fetchAlanRecommendDietary(ingredients: [IngredientEntity]) async throws -> [RecommendEntity]
}

//MARK: - usecaseimpl

final class NetworkUseCaseImpl : NetworkUseCase {
    
    private let repository: NetworkRepository
    private let encoder: JSONEncoder
    
    public init(repository: NetworkRepository,
                encoder: JSONEncoder = JSONEncoder()) {
        self.repository = repository
        self.encoder = encoder
    }
    
    func fetchAlanRecommendDietary(ingredients: [IngredientEntity]) async throws -> [RecommendEntity] {
        // 1. 재료 이름만 추출
        let names = ingredients.map { $0.name }
        
        // 2. 프롬프트 생성
        let prompt = """
            당신은 영양사입니다. 다음 재료로 만들 수 있는 건강한 식단을 추천해 주세요. 응답은 JSON 배열 형태로 제공해 주세요.
            이 세상에 존재하는 메뉴이어야 하고 메뉴가 너무 변형되거나 핀트가 벗어난 음식은 알려주지 말아야해요.
            그리고 영양학적으로 균형잡힌 식사메뉴여야해요.
            
            {
              "recommendations": [
                { "title": "제목1", "description": "설명1" },
                { "title": "제목2", "description": "설명2" }
              ]
            }
            
            재료: \(names.joined(separator: ", "))
            """
        
        // 3. API 호출
        let alanResponse = try await repository.NetWorkToAlan(content: prompt)
        let rawContent = alanResponse.content
        
        // 4. JSON 부분만 추출
        guard let start = rawContent.firstIndex(of: "{"),
              let end = rawContent.lastIndex(of: "}") else {
            throw NetworkError.invalidResponse
        }
        let jsonString = String(rawContent[start...end])
        let jsonData = Data(jsonString.utf8)
        
        // 5. 디코딩
        struct RecommendationWrapper: Decodable {
            let recommendations: [RecommendEntity]
        }
        let wrapper = try JSONDecoder().decode(RecommendationWrapper.self, from: jsonData)
        return wrapper.recommendations
    }
}
