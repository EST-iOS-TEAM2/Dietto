//
//  DietaryViewModel.swift
//  Dietto
//
//  Created by 안세훈 on 5/14/25.
//

import SwiftUI

class DietaryViewModel: ObservableObject {
    
    //현재
    @Published var presentIngredients: [IngredientEntity] = []
    
    //과거
    @Published var pastIngredients : [IngredientEntity] = [
        IngredientEntity(name: "오징어"),
        IngredientEntity(name: "꼴뚜기"),
        IngredientEntity(name: "홍합"),
        IngredientEntity(name: "닭다리"),
        IngredientEntity(name: "연어머리"),
        IngredientEntity(name: "마늘"),
        IngredientEntity(name: "올리브유"),
        IngredientEntity(name: "양파"),
        IngredientEntity(name: "국간장"),
        IngredientEntity(name: "밀가루"),
        IngredientEntity(name: "참기름"),
        IngredientEntity(name: "들기름"),
        IngredientEntity(name: "통후추"),
        IngredientEntity(name: "미역"),
        IngredientEntity(name: "감자"),
        IngredientEntity(name: "와인"),
        IngredientEntity(name: "당근"),
        IngredientEntity(name: "배추")
    ]
    
    //추천 리스트
    @Published var recommendList : [RecommendEntity]  = [
        ///Dummy
        ///
        RecommendEntity(title: "음식1", description: "대충만듭니다.하지만 대충 만든다고 맛이 없지는 않습니다. 요리하는 사람의 정성이 들어가야하며 손맛도 중요합니다. 하지만 손맛이 중요하다고 손을 넣는 것은 아닙니다. 왜냐하면 손을 넣기 위해서는 왼손, 오른손 중 하나를 택해야 하기 때문입니다. 왼손잡이일 경우 왼손을 넣는 다면, 사는데 불편할 것이 분명합니다. 그럼 오른손을 넣겠지요? 그럼 인도 여행을 가지 못합니다. 인도는 오른손으로 밥을 먹기 때문입니다."),
        RecommendEntity(title: "음식2", description: "123"),
        RecommendEntity(title: "음식3", description: "123"),
        RecommendEntity(title: "음식4", description: "대충만듭니다.하지만 대충 만든다고 맛이 없지는 않습니다. 요리하는 사람의 정성이 들어가야하며 손맛도 중요합니다. 하지만 손맛이 중요하다고 손을 넣는 것은 아닙니다. 왜냐하면 손을 넣기 위해서는 왼손, 오른손 중 하나를 택해야 하기 때문입니다. 왼손잡이일 경우 왼손을 넣는 다면, 사는데 불편할 것이 분명합니다. 그럼 오른손을 넣겠지요? 그럼 인도 여행을 가지 못합니다. 인도는 오른손으로 밥을 먹기 때문입니다."),
        RecommendEntity(title: "음식5", description: "123"),
        RecommendEntity(title: "음식6", description: "대충만듭니다.하지만 대충 만든다고 맛이 없지는 않습니다. 요리하는 사람의 정성이 들어가야하며 손맛도 중요합니다. 하지만 손맛이 중요하다고 손을 넣는 것은 아닙니다. 왜냐하면 손을 넣기 위해서는 왼손, 오른손 중 하나를 택해야 하기 때문입니다. 왼손잡이일 경우 왼손을 넣는 다면, 사는데 불편할 것이 분명합니다. 그럼 오른손을 넣겠지요? 그럼 인도 여행을 가지 못합니다. 인도는 오른손으로 밥을 먹기 때문입니다."),
        RecommendEntity(title: "음식7", description: "123"),
        RecommendEntity(title: "음식8", description: "123"),
        RecommendEntity(title: "음식9", description: "123"),
        RecommendEntity(title: "음식10", description: "123")
    ]
    
    
    private let usecase : AlanUsecase
    
    //MARK: - init
    init(usecase: AlanUsecase = AlanUsecaseImpl(repository: NetworkRepositoryImpl())) {
        self.usecase = usecase
    }
    
    //MARK: - 현재 식단에 있는거 생성
    func addpresentIngredients(_ ingredient: String) {
        let trimmed = ingredient.trimmingCharacters(in: .whitespacesAndNewlines)
        guard !trimmed.isEmpty,
              !presentIngredients.contains(where: { $0.name == trimmed }) else { return }
        
        presentIngredients.append(IngredientEntity(name: trimmed))
    }
    //MARK: - 현재 식단에 있는거 삭제
    func removepresentIngredients(_ ingredient: IngredientEntity) {
        presentIngredients.removeAll { $0.id == ingredient.id }
    }
    
    //MARK: - 과거 식단으로 추가
    //    func addpastIngredients(ingredients: [IngredientEntity]) {
    //        for ingredient in ingredients {
    //            if let index = presentIngredients.firstIndex(where: { $0.name == ingredient.name }) {
    //                let removed = presentIngredients.remove(at: index)
    //                if !pastIngredients.contains(where: { $0.name == removed.name }) {
    //                    pastIngredients.append(removed)
    //                }
    //            }
    //        }
    //    }
    
    //MARK: - 과거 식단에 있던거 삭제
    func removepastIngredients(_ ingredient: IngredientEntity) {
        pastIngredients.removeAll { $0.id == ingredient.id }
    }
    
    //MARK: - 현재 재료를 통해 식단 추천 받기.
    //mainactor <- thread./.
    #warning("쓰레드 확인해보기.")
    func fetchRecommendations(ingredients: [IngredientEntity]) async {
        do {
            let result = try await usecase.fetchRecommend(ingredients: ingredients)
            self.recommendList = result
//            Thread.isMainThread
//            MainActor.preconditionIsolated() //메인엑터 확인.
        } catch {
            print(#file,#function,#line, error.localizedDescription)
        }
    }
    
}
