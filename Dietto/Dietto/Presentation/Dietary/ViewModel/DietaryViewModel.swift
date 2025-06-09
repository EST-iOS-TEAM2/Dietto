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
    @Published var pastIngredients : [IngredientEntity] = []
    
    //추천 리스트
    @Published var recommendList : [RecommendEntity] = []
    
    private let alanUsecase : AlanUsecase
    private let ingredientUsecase : IngredientUsecase
    
    //MARK: - init
    init(
        alanUsecase: AlanUsecase ,
        ingredientUsecase : IngredientUsecase
    ) {
        self.alanUsecase = alanUsecase
        self.ingredientUsecase = ingredientUsecase
        
        loadPastIngredients()
    }
    
    //MARK: - 과거에 있던 식재료 가져오기.
    func loadPastIngredients() {
        Task{
            do {
                let result = try await ingredientUsecase.fetchIngredient()
                await MainActor.run {
                    self.pastIngredients = result
                }
            }
            catch {
                await MainActor.run {
                    self.toast = ToastEntity(
                        type: .error,
                        title: "조회 실패",
                        message: "과거 식재료 조회에 실패하였습니다."
                    )
                }
            }
        }
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
        Task {
            for ingredient in self.presentIngredients {
                if !self.pastIngredients.contains(where: { $0.ingredient == ingredient.ingredient }) {
                    do {
                        try await ingredientUsecase.insertIngredient(ingredient)
                        await MainActor.run {
                            self.pastIngredients.append(ingredient)
                        }
                    } catch {
                        await MainActor.run {
                            self.toast = ToastEntity(
                                type: .error,
                                title: "저장 실패",
                                message: "식재료 저장 중 오류가 발생했습니다."
                            )
                        }
                    }
                }
            }
            await MainActor.run {
                self.presentIngredients.removeAll()
            }
        }
    }
    
    
    //MARK: - 과거 식단에 있던거 삭제
    func removepastIngredients(_ ingredient: IngredientEntity) {
        Task {
            do {
                try await ingredientUsecase.deleteIngredient(ingredient)
                await MainActor.run {
                    self.pastIngredients.removeAll { $0.id == ingredient.id }
                    self.toast = ToastEntity(
                        type: .success,
                        title: "삭제 완료",
                        message: "선택한 식재료가 삭제되었습니다.",
                        duration: 2
                    )
                }
            } catch {
                await MainActor.run {
                    self.toast = ToastEntity(
                        type: .error,
                        title: "삭제 실패",
                        message: "식재료 삭제 중 오류가 발생했습니다."
                    )
                }
            }
        }
    }
    
    
    //MARK: - 현재 재료를 통해 식단 추천 받기.
    func fetchRecommendations(ingredients: [IngredientEntity]) {
        
        self.recommendList.removeAll()
        isPresneted = true
        pushToRecommend = true
        
        Task {
            do {
                let result = try await alanUsecase.fetchRecommend(ingredients: ingredients)
                await MainActor.run {
                    self.recommendList = result
                    
                    addpastIngredients()
                    
                    self.toast = ToastEntity(
                        type: .success,
                        title: "추천 완료",
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
                        title: "추천 에러",
                        message: error.localizedDescription
                    )
                    isPresneted = false
                }
            }
        }
    }
}
