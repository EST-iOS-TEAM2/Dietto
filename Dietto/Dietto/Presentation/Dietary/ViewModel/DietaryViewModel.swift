//
//  DietaryViewModel.swift
//  Dietto
//
//  Created by 안세훈 on 5/14/25.
//

import SwiftUI

class DietaryViewModel: ObservableObject {
    
    @Published var presentIngredients: [IngredientEntity] = []
    
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
    
    //MARK: - 지금 식단에 있는거 생성 / 삭제
    func addpresentIngredients(_ ingredient: String) {
        let trimmed = ingredient.trimmingCharacters(in: .whitespacesAndNewlines)
        guard !trimmed.isEmpty,
              !presentIngredients.contains(where: { $0.name == trimmed }) else { return }
        
        presentIngredients.append(IngredientEntity(name: trimmed))
    }
    
    func removepresentIngredients(_ ingredient: IngredientEntity) {
        presentIngredients.removeAll { $0.id == ingredient.id }
    }
    
    //MARK: - 과거 식단에 있던거 삭제
    func removepastIngredients(_ ingredient: IngredientEntity) {
        pastIngredients.removeAll { $0.id == ingredient.id }
    }
    
    
}
