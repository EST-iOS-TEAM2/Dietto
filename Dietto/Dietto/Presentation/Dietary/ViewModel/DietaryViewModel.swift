//
//  DietaryViewModel.swift
//  Dietto
//
//  Created by 안세훈 on 5/14/25.
//

import SwiftUI

class DietaryViewModel: ObservableObject {
    @Published var isPresneted : Bool = false //로딩 여부
    @Published var pushToRecommend : Bool = false //push여부
    @Published var toast: ToastEntity? //toast팝업
    @Published var presentIngredients: [IngredientEntity] = []     //현재
    @Published var pastIngredients : [IngredientEntity] = [
        //        IngredientEntity(ingredient: "오징어"),
        //        IngredientEntity(ingredient: "꼴뚜기"),
        //        IngredientEntity(ingredient: "홍합"),
        //        IngredientEntity(ingredient: "닭다리"),
        //        IngredientEntity(ingredient: "연어머리"),
        //        IngredientEntity(ingredient: "마늘"),
        //        IngredientEntity(ingredient: "올리브유"),
        //        IngredientEntity(ingredient: "양파"),
        //        IngredientEntity(ingredient: "국간장"),
        //        IngredientEntity(ingredient: "밀가루"),
        //        IngredientEntity(ingredient: "참기름"),
        //        IngredientEntity(ingredient: "들기름"),
        //        IngredientEntity(ingredient: "통후추"),
        //        IngredientEntity(ingredient: "미역"),
        //        IngredientEntity(ingredient: "감자"),
        //        IngredientEntity(ingredient: "와인"),
        //        IngredientEntity(ingredient: "당근"),
        //        IngredientEntity(ingredient: "배추")
    ]
    
    //추천 리스트
    @Published var recommendList : [RecommendEntity] = []
    
    private let usecase : AlanUsecase
    
    //MARK: - init
    init(usecase: AlanUsecase = AlanUsecaseImpl(repository: NetworkRepositoryImpl())) {
        self.usecase = usecase
    }
    
    //MARK: - 현재 식재료 생성
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
    
    //MARK: - 현재 식재료를 삭제하고 현재 식재료를 과거 식재료로 추가
    func addpastIngredients() {
        for ingredient in self.presentIngredients {
            if !self.pastIngredients.contains(where: { $0.ingredient == ingredient.ingredient }) {
                self.pastIngredients.append(ingredient)
            }
        }
        self.presentIngredients.removeAll()
    }
    
    //MARK: - 과거 식단에 있던거 삭제
    func removepastIngredients(_ ingredient: IngredientEntity) {
        pastIngredients.removeAll { $0.id == ingredient.id }
    }
    
    //MARK: - 현재 재료를 통해 식단 추천 받기.
    func fetchRecommendations(ingredients: [IngredientEntity]) {
        
        self.recommendList.removeAll()
        
        isPresneted = true
        
        Task {
            
            self.pushToRecommend = true
            
            do {
                let result = try await usecase.fetchRecommend(ingredients: ingredients)
                await MainActor.run {
                    self.recommendList = result
                    
                    addpastIngredients()
                    
                    self.toast = ToastEntity(
                        type: .success,
                        title: "완료",
                        message: "식단 추천을 완료하였습니다.",
                        duration: 2
                    )
                    isPresneted = false
                }
            } catch let error as NetworkError {
                await MainActor.run {
                    self.toast = error.asToast
                    isPresneted = false
                }
            }catch {
                await MainActor.run {
                    self.toast = ToastEntity(
                        type: .error,
                        title: "에러",
                        message: error.localizedDescription
                    )
                    isPresneted = false
                }
            }
        }
        
    }
}
