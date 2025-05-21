//
//  AlanUsecase.swift
//  Dietto
//
//  Created by 안세훈 on 5/19/25.
//

import Foundation

//MARK: - usecase

protocol AlanUsecase {
    func fetchAlanRecommendDietary(ingredients: [IngredientEntity]) async throws -> [RecommendEntity]
}

//MARK: - usecaseimpl
final class AlanUsecaseImpl : AlanUsecase {
    
    private let repository: NetworkRepository
    private let encoder: JSONEncoder
    
    init(repository: NetworkRepository, encoder: JSONEncoder = JSONEncoder()) {
        self.repository = repository
        self.encoder = encoder
    }
    
    func fetchAlanRecommendDietary(ingredients: [IngredientEntity]) async throws -> [RecommendEntity] {
        
        let names = ingredients.map { $0.name }
        
        /// 퓨샷(few-shot) 프롬프팅 기법은 프롬프트에서 데모를 제공하여 모델이 더 나은 성능을 발휘하도록 유도하는 문맥 내 학습을 가능하게 하는 기술
        /// 레게노 ㄷㄷ
        
        let prompt = """
            당신은 영양사입니다. 다음 재료로 만들 수 있는 건강한 식단을 추천해 주세요. 응답은 JSON 배열 형태로 제공해 주세요.
            이 세상에 존재하는 메뉴이어야 하고 메뉴가 너무 변형되거나 핀트가 벗어난 음식은 알려주지 말아야해요.
            그리고 영양학적으로 균형잡힌 식사메뉴여야해요. 최대 10개의 음식을 보여주세요. 하지만 10개보다 적어도 괜찮습니다.
            다음 예시를 참고해서 설명해주세요.
            
            {
              "recommendations": [
                { "title": "미역국", 
                  "description": " 1. 요즘에는 간편미역이라고 해서 씻은 미역을 20g 잘라담아서 팔고 있습니다 20g을 다하면 너무 양이 많아서 2인분용으로 절반만 썼어요 여기에 물을 넣으면 금방 불어납니다.
                                   2. 키친타월로 소고기 피를 살짝 뺍니다.
                                   3. 쌀뜬물로 하면 더 맛있다고 해요 첫번째는 그냥 버리고 두번째 쌀뜬 물로 준비합니다.
                                   4. 참기름을 두르고 소고기를 볶습니다 소고기라서 금방 익네요.
                                   5. 불린 미역을 물기를 빼서 넣고 3분정도 볶습니다.
                                   6. 냄비가 달라붙을거 같아서 코팅된 후라이팬에 볶았는데요 볶은 고기와 미역을 냄비로 옮겨놓고 쌀뜬물을 넣습니다.
                                   7. 마늘 반술을 넣습니다.
                                   8. 국간장 큰술 2를 넣습니다 나머지 간은 꽃소금을 넣어가면서 잡습니다 그리고 중불에 10분 약불에 20분정도 끓입니다.
                },
                { "title": "가지 스테이크",
                  "description": " 1. 가지의 꼭지 부분은 자르고 통으로 두께 1~2cm 크기로 자른다.
                                   2. 자른 가지는 그릇에 담아 전자레인지에 4~5분 정도 돌린다.
                                   3. 쌀뜬물로 하면 더 맛있다고 해요 첫번째는 그냥 버리고 두번째 쌀뜬 물로 준비합니다.
                                   4. 팬에 버터를 넣고 가지를 약불에서 앞뒤로 굽는다.
                                   5. 가지의 수분이 빠지고 노릇해지면 양념을 바른다.
                                   6. 양념을 바른 가지는 약불에서 앞뒤로 굽는다.
                }
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
            throw NetworkError.invalidResponse
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

