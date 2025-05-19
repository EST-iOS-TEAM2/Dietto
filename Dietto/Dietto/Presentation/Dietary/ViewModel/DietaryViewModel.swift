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
        IngredientEntity(name: "재료21"),
        IngredientEntity(name: "재료22"),
        IngredientEntity(name: "재료23"),
        IngredientEntity(name: "재료24"),
        IngredientEntity(name: "재료25"),
        IngredientEntity(name: "재료26"),
        IngredientEntity(name: "재료27"),
        IngredientEntity(name: "재료28"),
        IngredientEntity(name: "재료29"),
        IngredientEntity(name: "재료30"),
        IngredientEntity(name: "재료31"),
        IngredientEntity(name: "재료32"),
        IngredientEntity(name: "재료33"),
        IngredientEntity(name: "재료34"),
        IngredientEntity(name: "재료35"),
        IngredientEntity(name: "재료36"),
        IngredientEntity(name: "재료37"),
        IngredientEntity(name: "재료38")
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
