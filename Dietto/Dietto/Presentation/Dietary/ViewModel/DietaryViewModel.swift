//
//  DietaryViewModel.swift
//  Dietto
//
//  Created by 안세훈 on 5/14/25.
//

import SwiftUI

class DietaryViewModel: ObservableObject {
    //로딩 여부
    @Published var isPresneted : Bool = false
    
    //현재
    @Published var presentIngredients: [IngredientEntity] = []
    
    //과거
    @Published var pastIngredients : [IngredientEntity] = [
        IngredientEntity(ingredient: "오징어"),
        IngredientEntity(ingredient: "꼴뚜기"),
        IngredientEntity(ingredient: "홍합"),
        IngredientEntity(ingredient: "닭다리"),
        IngredientEntity(ingredient: "연어머리"),
        IngredientEntity(ingredient: "마늘"),
        IngredientEntity(ingredient: "올리브유"),
        IngredientEntity(ingredient: "양파"),
        IngredientEntity(ingredient: "국간장"),
        IngredientEntity(ingredient: "밀가루"),
        IngredientEntity(ingredient: "참기름"),
        IngredientEntity(ingredient: "들기름"),
        IngredientEntity(ingredient: "통후추"),
        IngredientEntity(ingredient: "미역"),
        IngredientEntity(ingredient: "감자"),
        IngredientEntity(ingredient: "와인"),
        IngredientEntity(ingredient: "당근"),
        IngredientEntity(ingredient: "배추")
    ]
    
    //추천 리스트
    @Published var recommendList : [RecommendEntity]  = []
    
    private let usecase : AlanUsecase
    
    //MARK: - init
    init(usecase: AlanUsecase = AlanUsecaseImpl(repository: NetworkRepositoryImpl())) {
        self.usecase = usecase
    }
    
    //MARK: - 현재 식단에 있는거 생성
    func addpresentIngredients(_ ingredient: String) {
        let trimmed = ingredient.trimmingCharacters(in: .whitespacesAndNewlines)
        guard !trimmed.isEmpty,
              !presentIngredients.contains(where: { $0.ingredient == trimmed }) else { return }
        
        presentIngredients.append(IngredientEntity(ingredient: trimmed))
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
    func fetchRecommendations(ingredients: [IngredientEntity]) {
        isPresneted = true
        Task {
            do {
                let result = try await usecase.fetchRecommend(ingredients: ingredients)
                await MainActor.run {
                    self.recommendList = result
                    isPresneted = false
                }
            } catch {
                print(#file,#function,#line, error.localizedDescription)
                isPresneted = false
            }
        }
    }
    
}

//            Thread.isMainThread
//            MainActor.preconditionIsolated() //메인엑터 확인.
