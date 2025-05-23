//
//  PromptManager.swift
//  Dietto
//
//  Created by 안세훈 on 5/23/25.
//

import Foundation

enum PromptType {
    case recommend
    case article
}

protocol PromptManager {
    func makePrompt(for type: PromptType, with values: [String]) -> String
}

final class PromptManagerImpl: PromptManager {
    
    func makePrompt(for type: PromptType, with values: [String]) -> String {

        let keywords = values.joined(separator: ", ")
        
        switch type{
        case .recommend:
            return """
                당신은 영양사입니다. 다음 재료로 만들 수 있는 건강한 식단을 추천해 주세요. 응답은 JSON 배열 형태로 제공해 주세요.
                이 세상에 존재하는 메뉴이어야 하고 메뉴가 너무 변형되거나 핀트가 벗어난 음식은 알려주지 말아야해요.
                그리고 영양학적으로 균형잡힌 식사메뉴여야해요. 최대 10개의 음식을 보여주세요. 하지만 10개보다 적어도 괜찮습니다.
                다음 예시를 참고해서 설명해주세요.
                
                {
                  "recommendation": [
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
                
                재료: \(keywords)
                """
            
        case .article:
            return """
            당신은 건강 전문 기자입니다. 다음 주제에 맞는 건강 기사를 작성해 주세요.
            주제: \(keywords)
            응답은 JSON `{ "articles": [...] }` 형태로만 제공해주세요.
            """
        }
    }
}
