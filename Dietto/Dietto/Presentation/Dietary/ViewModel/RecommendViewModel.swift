//
//  RecommendViewModel.swift
//  Dietto
//
//  Created by 안세훈 on 5/16/25.
//

import SwiftUI

@MainActor
final class RecommendViewModel : ObservableObject {
    
    @Published var recommendList : [RecommendEntity]  = []
    
    private let usecase : AlanUseCase
    
    init(usecase: AlanUseCase = AlanUseCaseImpl(repository: NetworkRepositoryImpl())) {
        self.usecase = usecase
    }
    
    //MARK: - 현재 재료를 통해 식단 추천 받기.
    func fetchRecommendations(ingredients: [IngredientEntity]) async {
        do {
            let result = try await usecase.fetchAlanRecommendDietary(ingredients: ingredients)
            self.recommendList = result
        } catch {
            print("Error fetching recommendations:", error)
        }
    }
}
